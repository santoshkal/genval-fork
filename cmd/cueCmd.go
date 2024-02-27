package cmd

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
	embeder "github.com/intelops/genval"
	"github.com/intelops/genval/pkg/cuecore"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type cueFlags struct {
	reqinput string
	resource string
	policy   string
	verify   bool
}

var cueArgs cueFlags

func init() {
	cueCmd.Flags().StringVarP(&cueArgs.reqinput, "reqinput", "r", "", "Input JSON for generating Dockerfile")
	cueCmd.MarkFlagRequired("reqinput")
	cueCmd.Flags().StringVarP(&cueArgs.resource, "resource", "p", "", "Path to write the Generated Dockefile")
	cueCmd.MarkFlagRequired("resource")
	cueCmd.Flags().StringVarP(&cueArgs.policy, "policy", "i", "", "Path for the Input policyin Rego, input-policy can be passed from either Local or from remote URL")
	cueCmd.MarkFlagRequired("policy")
	cueCmd.Flags().BoolVarP(&cueArgs.verify, "verify", "v", true, "Print the success/failure logs for generation if verify is false")

	// rootCmd.AddCommand(versionCmd)
	rootCmd.AddCommand(cueCmd)
}

var cueCmd = &cobra.Command{
	Use:   "cue",
	Short: "Generate and Validate Kubernetes manifests with Cuelang",
	Long:  `A user can pass an Kubernetes manifest in wither JSON/YAML format and Cue policies (Definition in Cue terms), and Genval will validate and Generate complete Kubernetes manifests`,
	Example: `
	./genval cue --resource=Deployment \
        --reqinput=deployment.json \
        --policy=<path/to/.cue schema>
    Note: The "resource" arg in "cue" mode needs a valid Kind, like "Deployment", "StatefulSet", "DaemonSet", etc.
		`,
	RunE: runCueCmd,
}

func runCueCmd(cmd *cobra.Command, args []string) error {
	const modPath = "github.com/intelops/genval"
	staticFS := embeder.CueDef

	td, cleanup, err := utils.TempDirWithCleanup()
	if err != nil {
		log.Fatal(err)
	}
	defer cleanup()
	defer func() {
		if err := utils.CleanupDownloadedDir(); err != nil {
			log.Printf("Error removing cue_downloads directory: %v", err)
		}
	}()

	ctx := cuecontext.New()

	// if resource == "" || reqinput == "" || len(policies) == 0 {
	// 	fmt.Println("[Usage]: genval --mode=cue --resource=<Resource> --reqinput=<Input JSON> --policy <path/to/.cue schema file>")
	// 	return
	// }

	dataPath := cueArgs.reqinput
	defPath := cueArgs.resource
	schemaFile := cueArgs.policy

	definitions, err := utils.ProcessInputs(schemaFile)
	if err != nil {
		log.Errorf("Error reading URL: %v", err)
	}

	// TODO: remove the 2nd return logic
	dataSet, _, err := utils.ReadAndCompileData(dataPath, defPath)
	if err != nil {
		log.Errorf("Error processing data: %v", err)
		return err
	}

	overlay, err := utils.GenerateOverlay(staticFS, td, definitions)
	if err != nil {
		log.Fatal(err)
	}

	conf := &load.Config{
		Dir:     td,
		Overlay: overlay,
		Module:  modPath,
		Package: "*",
	}

	defName := "#" + defPath

	v, err := cuecore.BuildInstance(ctx, definitions, conf)
	if err != nil {
		log.Fatal(err)
	}

	// Name of the output directory
	outputDir := "output"

	// Check if the output directory exists, if not create it
	if _, err := os.Stat(outputDir); os.IsNotExist(err) {
		err := os.Mkdir(outputDir, 0755)
		if err != nil {
			log.Fatalf("Error creating output directory: %v", err)
		}
	}

	var outputFiles []string
	for filePath, data := range dataSet {
		for _, value := range v {
			lookUp := cue.ParsePath(defName)
			def := value.LookupPath(lookUp)
			if def.Err() != nil {
				log.Errorf("Error parsing Path: %v", def.Err())
				return err
			}

			unifiedValue, err := cuecore.UnifyAndValidate(def, data)
			if err != nil {
				log.Errorf("Validation failed: %v", err)
				return err
			}

			// Only generate YAML if verify is set to false -- default
			if !verify {
				yamlData, err := parser.CueToYAML(unifiedValue)
				if err != nil {
					log.Errorf("Error Marshaling: %v", err)
					return err
				}

				baseName := filepath.Base(filePath)
				outputFileName := strings.TrimSuffix(baseName, filepath.Ext(baseName)) + ".yaml"
				fullOutputPath := filepath.Join(outputDir, outputFileName)

				err = os.WriteFile(fullOutputPath, yamlData, 0644)
				if err != nil {
					log.Errorf("Writing YAML: %v", err)
					return err
				}
				outputFiles = append(outputFiles, fullOutputPath)
			}
		}
	}

	// Only print the success log for generation if verify is false
	if !verify {
		log.Infof("%v validation succeeded, generated manifests in '%v':\n", defPath, outputDir)
		for _, fileName := range outputFiles {
			fmt.Printf(" - %v\n", fileName)
		}
	} else {
		log.Infof("%v validation succeeded\n\n", dataPath)
	}
	return nil
}

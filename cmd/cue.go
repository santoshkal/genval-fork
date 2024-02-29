package cmd

import (
	"errors"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
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
	if err := cueCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	cueCmd.Flags().StringVarP(&cueArgs.resource, "resource", "p", "", "Path to write the Generated Dockefile")
	if err := cueCmd.MarkFlagRequired("resource"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	cueCmd.Flags().StringVarP(&cueArgs.policy, "policy", "i", "", "Path for the Input policyin Rego, input-policy can be passed from either Local or from remote URL")
	if err := cueCmd.MarkFlagRequired("policy"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	cueCmd.Flags().BoolVarP(&cueArgs.verify, "verify", "v", false, "Verify only based on the policy")
	// rootCmd.AddCommand(versionCmd)
	rootCmd.AddCommand(cueCmd)
}

var cueCmd = &cobra.Command{
	Use:   "cue",
	Short: "Generate and Validate Kubernetes configuration with Cuelang",
	Long: `
A user can pass in a JSON/YAML manifests for Kubernetes or any other Kubernetes based technologies to genval, the passed input willbe validated,
with the Cue policies (Definitions in Cue's terminolgy) and the complete manifests willbe generasted in the ./output directory in pwd.

Provides flexibility of supplying input files in YAML or JSON formats, as well as policy files for input and output policies.
Genval supports both local file paths or remote URLs, such as those hosted on GitHub (e.g., https://github.com)
`,
	Example: `./genval cue --reqinput=input.json \
  --output=output.Dockerfile \
  --inputpolicy=<path/to/input.rego policy> \
  --outputpolicy=<path/to/output.rego file>`,
	RunE: runCueCmd,
}

func runCueCmd(cmd *cobra.Command, args []string) error {

	if len(args) < 1 {
		return errors.New("missing required args")
	}

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

	dataPath := cueArgs.reqinput
	defPath := cueArgs.resource
	schemaFile := cueArgs.policy

	definitions, err := utils.GetDefinitions(schemaFile)
	if err != nil {
		log.Fatalf("Error reading Cue Definitions: %v", err)
	}
	modPath, err := utils.ExtractModule(schemaFile)
	if err != nil {
		log.Errorf("Error fetching module: %v", err)
	}

	dataSet, err := cuecore.ReadAndCompileData(dataPath)
	if err != nil {
		log.Errorf("Error processing data: %v", err)
		return err
	}

	overlay, err := cuecore.GenerateOverlay(schemaFile, td, definitions)
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
		err := os.Mkdir(outputDir, 0o755)
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
			if !cueArgs.verify {
				yamlData, err := parser.CueToYAML(unifiedValue)
				if err != nil {
					log.Errorf("Error Marshaling: %v", err)
					return err
				}

				baseName := filepath.Base(filePath)
				outputFileName := strings.TrimSuffix(baseName, filepath.Ext(baseName)) + ".yaml"
				fullOutputPath := filepath.Join(outputDir, outputFileName)

				err = os.WriteFile(fullOutputPath, yamlData, 0o644)
				if err != nil {
					log.Errorf("Writing YAML: %v", err)
					return err
				}
				outputFiles = append(outputFiles, fullOutputPath)
			}
		}
	}

	// Only print the success log for generation if verify is false
	if !cueArgs.verify {
		log.Infof("%v validation succeeded, generated manifests in '%v' directory:\n", defPath, outputDir)
		for _, fileName := range outputFiles {
			fmt.Printf(" - %v\n", fileName)
		}
	}
	log.Infof("%v validation succeeded\n\n", dataPath)
	return nil
}

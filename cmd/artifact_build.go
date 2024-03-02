package cmd

import (
	"fmt"
	"os"
	"path/filepath"

	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/pkg/builder"
)

var buildCmd = &cobra.Command{
	Use:   "build",
	Short: "The artifact build command bundles the provided file/s into a OCI compatible tar gz bundle",
	Long: `
	The artifact build command takes in a directory or a set of configuration files generated/validated by Genval
and bundles them into a OCI complient tar.gz bundle ready to be pushed to an OCI complient container registry
`,
	Example: `
# Build the generated/validated set of files in to a OCI bundle

genval artifact build --reqinput <path to source files/directory> \
--output <path to store the OCI bundle>
`,
	RunE: runBuildCmd,
}

type buildFlags struct {
	reqinput string
	output   string
	// annotations []string
}

var buildArgs buildFlags

func init() {
	buildCmd.Flags().StringVarP(&buildArgs.reqinput, "reqinput", "r", "", "Path to the source files to build artifact from")
	if err := buildCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	buildCmd.Flags().StringVarP(&buildArgs.output, "output", "o", ".", "Path for storing the built artifact")
	if err := buildCmd.MarkFlagRequired("output"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	// buildCmd.Flags().StringArrayVarP(&buildArgs.annotations, "annotations", "a", nil, "Set custom annotation in <key>=<value> format")

	artifactCmd.AddCommand(buildCmd)
}

func runBuildCmd(cmd *cobra.Command, args []string) error {
	if buildArgs.reqinput == "" || buildArgs.output == "" {
		log.Printf("Required args mising")
	}

	inputPath := buildArgs.reqinput
	outputPath := buildArgs.output

	inputDir := filepath.Dir(inputPath)
	if err := checkPathExists(inputDir); err != nil {
		log.Errorf("Error reading %s: %v\n", inputPath, err)
		os.Exit(1)
	}

	outputDir := filepath.Dir(outputPath)
	if err := checkPathExists(outputDir); err != nil {
		log.Errorf("Error reading %s: %v\n", outputPath, err)
		os.Exit(1)
	}

	log.Printf("✔ Building artifact from: %v", inputPath)

	// Create a tarball from the input path
	if err := builder.CreateTarball(inputPath, outputPath); err != nil {
		return fmt.Errorf("creating tarball: %w", err)
	}
	log.Printf("✔ Artifact created successfully at: %s\n", outputPath)
	return nil
}
func checkPathExists(path string) error {
	if _, err := os.Stat(path); os.IsNotExist(err) {
		return err
	}
	return nil
}

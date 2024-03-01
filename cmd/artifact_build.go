package cmd

import (
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
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
	reqinput    string
	output      string
	annotations []string
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
	buildCmd.Flags().StringArrayVarP(&buildArgs.annotations, "annotations", "a", nil, "Set custom annotation in <key>=<value> format")

	artifactCmd.AddCommand(buildCmd)
}

func runBuildCmd(cmd *cobra.Command, args []string) error {
	// Add functionality to build artifact
	return nil
}

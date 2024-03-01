package cmd

import (
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

var pushCmd = &cobra.Command{
	Use:   "push",
	Short: "The artifact push command pushes the tar.gz bundle to an OCI complient container registry",
	Long: `
	The artifact push command takes in a tar.gz bundle of configuration files generated/validated by Genval
and pushes them into a OCI complient container registry
`,
	Example: `
# push the generated/validated set of files in to a OCI bundle

genval artifact push --reqinput <path to tar.gz> \
--url <url for OCI registry>
`,
	RunE: runPushCmd,
}

type pushFlags struct {
	reqinput    string
	url         string
	annotations []string
}

var pushArgs pushFlags

func init() {
	pushCmd.Flags().StringVarP(&pushArgs.reqinput, "reqinput", "r", "", "path to the artifact (tar.gz) source files to push")
	if err := pushCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	pushCmd.Flags().StringVarP(&pushArgs.url, "url", "u", ".", "URL for the registry")
	if err := pushCmd.MarkFlagRequired("url"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	pushCmd.Flags().StringArrayVarP(&pushArgs.annotations, "annotations", "a", nil, "Set custom annotation in <key>=<value> format")

	artifactCmd.AddCommand(pushCmd)
}

func runPushCmd(cmd *cobra.Command, args []string) error {
	// Add functionality to push artifact
	return nil
}

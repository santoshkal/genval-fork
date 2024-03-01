package cmd

import (
	"github.com/spf13/cobra"
)

var artifactCmd = &cobra.Command{
	Use:   "artifact",
	Short: "Command that manages building and pushing OCI artifacts",
	Long: `
artifact command providesd capabilities for building and pushing of the OCI complient artifacts built form the
generated/validated config files using Genval.`,
}

func init() {
	rootCmd.AddCommand(artifactCmd)
}

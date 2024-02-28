package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

// rootCommand returns a cobra command for genvalctl CLI tool
var rootCmd = &cobra.Command{
	Use:     "genval",
	Version: "0.0.1",
	Short:   "genvalctl is a CLI tool to generate and validate files",
	Long: `
Genval is a versatile Go utility that simplifies configuration management by Generating and validating cobfig files
for a wide range of tools, including Dockerfile, Kubernetes manifests, Terraform files, Tekton, ArgoCD and more.
		`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println(`
Genval is a versatile Go utility that simplifies configuration management by Generating and validating cobfig files
for a wide range of tools, including Dockerfile, Kubernetes manifests, Terraform files, Tekton, ArgoCD and more.
	`)
	},
}

func Execute() {
	rootCmd.AddCommand(versionCmd)
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

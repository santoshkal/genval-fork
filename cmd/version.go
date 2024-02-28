package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
)

var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "Print the version number of Hugo",
	Long:  `All software has versions. This is Genval's`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("Genval config manager v0.0.1 -- HEAD")
	},
}

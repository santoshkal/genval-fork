package cmd

import (
	"errors"

	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/validate"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type tfFlags struct {
	reqinput string
	policy   string
}

var tfArgs tfFlags

func init() {
	tfCmd.Flags().StringVarP(&tfArgs.reqinput, "reqinput", "r", "", "Input JSON for validating Terraform .tf files with rego")
	tfCmd.MarkFlagRequired("reqinput")
	tfCmd.Flags().StringVarP(&tfArgs.policy, "policy", "p", "", "Path for the Rego policy file, polciy can be passed from either Local or from remote URL")
	tfCmd.MarkFlagRequired("policy")

	// rootCmd.AddCommand(versionCmd)
	rootCmd.AddCommand(tfCmd)
}

var tfCmd = &cobra.Command{
	Use:   "tf",
	Short: "Validate Terraform .tf files with Rego policies",
	Long: `With tf mode, a user can validate raw terraform file with .tf extions. 
Provide a valid terraform file with .tf extension in the --reqinput arg and a set of Rego policies in the
--policy arg.

The requried input .tf files and  Rego policy files can be either be passed through local file paths or remote URLs,
such as those hosted on GitHub (e.g., https://github.com)
`,
	Example: `./genval tf --reqinput=input.json \
	--policy=<path/to/policy.rego file>`,
	RunE: runTfCmd,
}

func runTfCmd(cmd *cobra.Command, args []string) error {
	if len(args) < 1 {
		return errors.New("missing required args")
	}

	inputFile := tfArgs.reqinput
	policy := tfArgs.policy

	inputJSON, err := parser.ConvertTFtoJSON(inputFile)
	if err != nil {
		log.Errorf("Error converting tf file: %v", err)
	}

	err = validate.ValidateWithRego(inputJSON, policy)
	if err != nil {
		log.Errorf("Validation %v failed", err)
	}
	log.Infof("Terraform resource: %v, validated succussfully.", inputFile)
	return nil
}

package cmd

import (
	"errors"
	"os"

	"github.com/intelops/genval/pkg/validate"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type dockervalFlags struct {
	reqinput string
	policy   string
}

var dockervalArgs dockervalFlags

func init() {
	dockervalCmd.Flags().StringVarP(&dockervalArgs.reqinput, "reqinput", "r", "", "Input JSON for validating Terraform .dockerval files with rego")
	if err := dockervalCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	dockervalCmd.Flags().StringVarP(&dockervalArgs.policy, "policy", "p", "", "Path for the Rego policy file, polciy can be passed from either Local or from remote URL")
	if err := dockervalCmd.MarkFlagRequired("policy"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	// rootCmd.AddCommand(versionCmd)
	rootCmd.AddCommand(dockervalCmd)
}

var dockervalCmd = &cobra.Command{
	Use:   "dockerval",
	Short: "Validate Dockerfile with Rego policies",
	Long: `Using dockerval, a user can validate Dockerfiles. Provide a Dockerfile thet needs to be validated
to the --reqinput arg and a set of Rego policies in the --policy arg.

The required input Dockerfile and  Rego policy files can be either be passed through local file paths or remote URLs,
such as those hosted on GitHub (e.g., https://github.com)
`,
	Example: `
	// Providing the required args from local file system
	./genval dockerval --reqinput=input.json \
	--policy=<'path/to/policy.rego file>
	`,
	RunE: runDockervalCmd,
}

func runDockervalCmd(cmd *cobra.Command, args []string) error {

	if len(args) < 1 {
		return errors.New("missing required args")
	}

	input := dockervalArgs.reqinput
	policy := dockervalArgs.policy

	dockerfileContent, err := os.ReadFile(input)
	if err != nil {
		log.Errorf("Error reading Dockerfile: %v, validation failed: %s\n", input, err)
	}

	err = validate.ValidateDockerfile(string(dockerfileContent), policy)
	if err != nil {
		log.Errorf("Dockerfile validation failed: %s\n", err)
	}
	log.Infof("Dockerfile: %v validation succeeded!\n", input)
	return nil
}

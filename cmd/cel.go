package cmd

import (
	"encoding/json"
	"errors"
	"os"

	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/validate"
	"github.com/jedib0t/go-pretty/v6/table"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type celFlags struct {
	reqinput string
	policy   string
}

var celArgs celFlags

func init() {
	celCmd.Flags().StringVarP(&celArgs.reqinput, "reqinput", "r", "", "Input JSON/YAML for validating Kubernetes configurations with CEL")
	if err := celCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	celCmd.Flags().StringVarP(&celArgs.policy, "policy", "p", "", "Path for the CEL policy file, polciy can be passed from either Local or from remote URL")
	if err := celCmd.MarkFlagRequired("policy"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	rootCmd.AddCommand(celCmd)
}

var celCmd = &cobra.Command{
	Use:   "cel",
	Short: "Validate Kubernetes and related manifests using Common Expression Language (CEL) policies",
	Long: `A user need to pass the Kubernetes manifest in YAML/JSON format as reqinput and a set of CEL policies
as a policy file for validation.

The required input file in YAML/JSON format or CEL policy file can be supplied either through a local file path
or from remote URL's such as those hosted on GitHub (e.g., https://github.com)
 `,
	Example: `./genval cel --reqinput=input.json \
  --policy=<path/to/policy.rego file>`,
	RunE: runCelCmd,
}

func runCelCmd(cmd *cobra.Command, args []string) error {
	if len(args) < 1 {
		return errors.New("missing required args")
	}
	inputFile := celArgs.reqinput
	policy := celArgs.policy

	var data interface{}
	err := parser.ParseDockerfileInput(string(inputFile), &data)
	if err != nil {
		log.Fatalf("Unable to process input: %v", err)
	}
	data = parser.ConvertToJSON(data)

	jsonManifest, err := json.Marshal(data)
	if err != nil {
		log.Fatalf("Error marshaling manifest data to JSON: %v", err)
	}

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy Name", "Result"})

	err = validate.EvaluateCELPolicies(policy, string(jsonManifest), t)
	if err != nil {
		log.Fatalf("Error evaluating policies: %v", err)
	}

	t.Render()
	return nil
}

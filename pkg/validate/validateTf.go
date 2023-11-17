package validate

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"os"

	"github.com/fatih/color"
	"github.com/intelops/genval/pkg/utils"
	"github.com/jedib0t/go-pretty/v6/table"
	"github.com/open-policy-agent/opa/rego"
	log "github.com/sirupsen/logrus"
)

func ValidateTf(inputContent string, regoPolicy string) error {
	jsonData := []byte(inputContent)

	k8sPolicy, err := utils.ReadPolicyFile(regoPolicy)
	if err != nil {
		log.WithError(err).Error("Error reading the policy file.")
		return err
	}

	var commands map[string]interface{}
	err = json.Unmarshal(jsonData, &commands)
	if err != nil {
		log.Errorf("Cannot Unmarshal jsonData: %v", err)
	}
	ctx := context.Background()

	// Create regoQuery for evaluation
	regoQuery := rego.New(
		rego.Query("data.validate_tf"),
		rego.Module(regoPolicy, string(k8sPolicy)),
		rego.Input(commands),
	)
	fmt.Printf("Commands: %v", commands)

	// Evaluate the Rego query
	rs, err := regoQuery.Eval(ctx)
	if err != nil {
		log.Fatal("Error evaluating query:", err)
	}

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy", "Status"})
	var policyError error

	for _, result := range rs {
		if len(result.Expressions) > 0 {
			keys := result.Expressions[0].Value.(map[string]interface{})
			for key, value := range keys {
				if value != true {
					errMsg := fmt.Sprintf("Validation policy: %s failed", key)
					fmt.Println(color.New(color.FgRed).Sprintf(errMsg))
					t.AppendRow(table.Row{key, color.New(color.FgRed).Sprint("failed")})
					policyError = errors.New(errMsg)
				} else {
					passMsg := fmt.Sprintf("Validation policy: %s passed", key)
					fmt.Println(color.New(color.FgGreen).Sprintf(passMsg))
					t.AppendRow(table.Row{key, color.New(color.FgGreen).Sprint("passed")})
				}
			}
		} else {
			log.Error("No policies passed")
		}
	}

	// Render the table to STDOUT
	t.Render()

	if err != nil {
		return errors.New("error evaluating Rego")
	}

	return policyError

}

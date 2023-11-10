package validate

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"os"

	"github.com/intelops/genval/pkg/utils"
	"github.com/open-policy-agent/opa/rego"
	log "github.com/sirupsen/logrus"
)

func ValidateK8s(inputContent string, regoPolicy string) error {
	k8sPolicy, err := utils.ReadPolicyFile(regoPolicy)
	if err != nil {
		log.WithError(err).Error("Error reading the policy file.")
		return err
	}

	jsonData, err := os.ReadFile(inputContent)
	if err != nil {
		log.Fatalf("Error reading JSON file: %v", err)
	}

	var commands map[string]interface{}
	err = json.Unmarshal(jsonData, &commands)
	if err != nil {
		log.Errorf("Cannot Unmarshal jsonData: %v", err)
	}
	ctx := context.Background()

	// Create regoQuery for evaluation
	regoQuery := rego.New(
		rego.Query("data.validate_k8s"),
		rego.Module(regoPolicy, string(k8sPolicy)),
		rego.Input(commands),
	)

	// Evaluate the Rego query
	rs, err := regoQuery.Eval(ctx)
	if err != nil {
		log.Fatal("Error evaluating query:", err)
	}

	var policyError error

	for _, result := range rs {
		if len(result.Expressions) > 0 {
			keys := result.Expressions[0].Value.(map[string]interface{})
			for key, value := range keys {
				if value != true {
					log.Errorf("Kubernetes validation policy: %s failed\n", key)
					policyError = fmt.Errorf("kubernetes validation policy: %s failed", key)
				} else {
					fmt.Printf("Dockerfile validation policy: %s passed\n", key)
				}
			}
		} else {
			log.Error("No policies passed")
		}
	}

	if err != nil {
		log.WithError(err).Error("Error evaluating Rego.")
		return errors.New("error evaluating Rego")
	}

	return policyError
}

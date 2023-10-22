package validate

import (
	"context"
	_ "embed"
	"encoding/json"
	"errors"
	"fmt"

	"github.com/intelops/genval/pkg/parser"
	"github.com/open-policy-agent/opa/rego"
	log "github.com/sirupsen/logrus"
)

//go:embed dockerFilePolicies.rego
var dockerPolicy []byte

const (
	// DockerfilePolicy = "./policies/dockerFilePolicies/dockerFilePolicies.rego"
	DockerfilePolicy = "dockerFilePolicies.rego"

	DockerfilePackage = "data.dockerfile_validation"
)

// ValidateDockerfileUsingRego validates a Dockerfile using Rego.
func ValidateDockerfile(dockerfileContent string, regoPolicyPath string) error {

	// Read Rego policy code from file
	// regoPolicyCode, err := os.ReadFile(regoPolicyPath)
	// if err != nil {
	// 	return fmt.Errorf("error reading rego policy: %v", err)
	// }

	// Prepare Rego input data
	dockerfileInstructions := parser.ParseDockerfileContent(dockerfileContent)

	jsonData, err := json.Marshal(dockerfileInstructions)
	if err != nil {
		log.WithError(err).Error("Error converting to JSON:", err)
		return errors.New("error converting to JSON")
	}

	var commands []map[string]string
	err = json.Unmarshal([]byte(jsonData), &commands)
	if err != nil {
		errWithContext := fmt.Errorf("error converting JSON to map: %v", err)
		log.WithError(err).Error(errWithContext.Error())
		return errWithContext
	}

	ctx := context.Background()

	// Create regoQuery for evaluation
	regoQuery := rego.New(
		rego.Query(DockerfilePackage),
		rego.Module(DockerfilePolicy, string(dockerPolicy)),
		rego.Input(commands),
	)

	// Evaluate the Rego query
	rs, err := regoQuery.Eval(ctx)
	if err != nil {
		log.Fatal("Error evaluating query:", err)
	}
	// fmt.Printf("This si Allowed: %v", rs[0].Expressions[0].Value)

	// Iterate over the resultSet and print the result metadata
	for _, result := range rs {
		if len(result.Expressions) > 0 {
			keys := result.Expressions[0].Value.(map[string]interface{})
			// fmt.Printf("VALUE: %v", result.Expressions[0].Value)
			for key, value := range keys {
				if valSlice, ok := value.([]interface{}); ok {
					for _, item := range valSlice {
						if val, ok := item.(string); ok {
							fmt.Println(val)
						}
					}
				} else {
					log.Errorf("Value for key %v is not a []interface{}", key)
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
	return nil
}

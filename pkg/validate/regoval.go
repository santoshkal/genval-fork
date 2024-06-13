package validate

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"path/filepath"

	"github.com/intelops/genval/pkg/oci"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/open-policy-agent/opa/ast"
	"github.com/open-policy-agent/opa/rego"
)

func ValidateWithRego(inputContent string, regoPolicyPath string) error {
	metaFiles, regoPolicy, err := FetchRegoMetadata(regoPolicyPath, metaExt, policyExt)
	if err != nil {
		return err
	}
	// Load metadata from JSON files
	metas, err := LoadRegoMetadata(metaFiles)
	if err != nil {
		return fmt.Errorf("error loading policy metadata: %v", err)
	}

	var allResults rego.ResultSet

	for _, regoFile := range regoPolicy {
		// read input is a file
		jsonData, err := parser.ProcessInput(inputContent)
		if err != nil {
			return fmt.Errorf("error reading input content file: %v", err)
		}

		k8sPolicy, err := utils.ReadFile(regoFile)
		if err != nil {
			return fmt.Errorf("error reading the policy file %s: %v", regoFile, err)
		}

		pkg, err := utils.ExtractPackageName(k8sPolicy)
		if err != nil {
			return fmt.Errorf("unable to fetch package name: %v", err)
		}

		policyName := filepath.Base(regoFile)

		var commands map[string]interface{}
		err = json.Unmarshal(jsonData, &commands)
		if err != nil {
			return fmt.Errorf("error Unmarshalling jsonData: %v", err)
		}
		ctx := context.Background()
		compiler, err := ast.CompileModules(map[string]string{
			policyName: string(k8sPolicy),
		})
		if err != nil {
			log.Fatal(err)
			return fmt.Errorf("failed to compile rego policy: %w", err)
		}
		// Create regoQuery for evaluation
		regoQuery := rego.New(
			rego.Query("data."+pkg),
			rego.Compiler(compiler),
			rego.Input(commands),
		)

		// Evaluate the Rego query
		rs, err := regoQuery.Eval(ctx)
		if err != nil {
			return fmt.Errorf("error evaluating query:%v", err)
		}
		allResults = append(allResults, rs...)
	}

	if err := PrintResults(allResults, metas); err != nil {
		return fmt.Errorf("error evaluating rego results for %s: %v", regoPolicyPath, err)
	}
	return nil
}

func ApplyDefaultPolicies(ociURL, path string) (string, error) {
	if err := oci.PullArtifact(context.Background(), ociURL, path); err != nil {
		return "", fmt.Errorf("error pulling policy from %s: %v", ociURL, err)
	}

	return path, nil
}

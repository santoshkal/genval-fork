package k8s

import (
	"fmt"
	"os"

	"github.com/intelops/genval/pkg/parser"
	validate "github.com/intelops/genval/pkg/validate/dockerfile_val"
	log "github.com/sirupsen/logrus"
)

func Execute(reqinput string, policies ...string) {
	if reqinput == "" || len(policies) == 0 {
		fmt.Println("[USAGE]: ./genval --mode=k8s --reqinput=input.json/yaml --policy=<path/to/rego policy>.")
		return
	}

	inputFile := reqinput
	policy := policies

	var data interface{}

	err := parser.ReadAndParseFile(inputFile, &data)
	if err != nil {
		log.Error("Error reading input file:", err)
		return
	}

	jsonData, err := os.ReadFile(inputFile)
	if err != nil {
		log.Fatalf("Error reading JSON file: %v", err)
	}

	for _, p := range policy {
		err = validate.ValidateInput(string(jsonData), p)
		if err != nil {
			log.Fatalf("Validation error: %v", err)
			return
		} else {
			fmt.Printf("Input JSON validation succeeded!\n")
		}
	}

}

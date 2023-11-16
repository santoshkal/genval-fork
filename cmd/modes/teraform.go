package modes

import (
	"fmt"

	"github.com/intelops/genval/pkg/parser"
	validate "github.com/intelops/genval/pkg/validate/k8s"
	log "github.com/sirupsen/logrus"
)

func ExecuteTf(reqinput string, policies ...string) {
	if reqinput == "" || len(policies) == 0 {
		fmt.Println("[USAGE]: ./genval --mode=tf --reqinput=input.json/yaml --policy=<path/to/rego policy>.")
		return
	}

	inputFile := reqinput
	policy := policies[0]

	inputJSON, err := parser.ConvertTFtoJSON(inputFile)
	if err != nil {
		log.Errorf("Error converting tf file: %v", err)
	}

	err = validate.ValidateK8s(inputJSON, policy)
	if err != nil {
		log.Errorf("Error parsing Terraform resource: %v", err)
		return
	}
}

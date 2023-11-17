package modes

import (
	"fmt"

	"github.com/intelops/genval/pkg/parser"
	validate "github.com/intelops/genval/pkg/validate"
	log "github.com/sirupsen/logrus"
)

func ExecuteTf(reqinput, inputpolicy string) {
	if reqinput == "" || inputpolicy == "" {
		fmt.Println("[USAGE]: ./genval --mode=tf --reqinput=input.json/yaml --policy=<path/to/rego policy>.")
		return
	}

	inputFile := reqinput
	policy := inputpolicy

	inputJSON, err := parser.ConvertTFtoJSON(inputFile)
	if err != nil {
		log.Errorf("Error converting tf file: %v", err)
	}

	err = validate.ValidateTf(inputJSON, policy)
	if err != nil {
		log.Errorf("Validation %v failed", err)
		return
	}
}

package modes

import (
	"fmt"

	validate "github.com/intelops/genval/pkg/validate/k8s"
)

func ExecuteK8s(reqinput, inputpolicy string) {
	if reqinput == "" || inputpolicy == "" {
		fmt.Println("[USAGE]: ./genval --mode=k8s --reqinput=input.json/yaml --policy=<path/to/rego policy>.")
		return
	}

	inputFile := reqinput
	policy := inputpolicy

	err := validate.ValidateK8s(string(inputFile), policy)
	if err != nil {
		return
	}
}

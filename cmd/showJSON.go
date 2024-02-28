package cmd

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"strings"

	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type showJSONFlags struct {
	reqinput string
}

var showJSONArgs showJSONFlags

func init() {
	showJSONCmd.Flags().StringVarP(&showJSONArgs.reqinput, "reqinput", "r", "", "required input as .tf or a Dockefile ")
	showJSONCmd.MarkFlagRequired("reqinput")

	// rootCmd.AddCommand(versionCmd)
	rootCmd.AddCommand(showJSONCmd)
}

var showJSONCmd = &cobra.Command{
	Use:   "tf",
	Short: "A helper command for printing the JSON representation of .tf and Dockerfile",
	Long: `showJSON command is a helper command enabling user to visualize the JSON representation of the .tf and Dockerfiles.
The succussfule execution of the command will print the JSON representation of the passed input .tf or a Dockefile to thge StdOut.
Based on this JSON representation, users can write Rego or CEL polices for their technologies and validate them through Genval.
	
The required input as .tf or a Dockerfile can be either passed through local file paths or remote URLs, such as those hosted on GitHub (e.g., https://github.com)
	`,
	Example: `./genval tf --reqinput=input.json \
	--policy=<path/to/policy.rego file>`,
	RunE: runshowJSONCmd,
}

func runshowJSONCmd(cmd *cobra.Command, args []string) error {
	if showJSONArgs.reqinput == "" {
		fmt.Println("[USAGE]: ./genval showJSON --reqinput=Dockerfile/ec2.tf")
		log.Panicf("Required params not found")
	}
	input := showJSONArgs.reqinput
	var prettyJSON bytes.Buffer

	if strings.HasSuffix(input, ".tf") {
		inputJSON, err := parser.ConvertTFtoJSON(input)
		if err != nil {
			log.Errorf("Error converting tf file: %v", err)
			return err
		}

		err = json.Indent(&prettyJSON, []byte(inputJSON), "", "    ")
		if err != nil {
			log.Errorf("Error: %v", err)
			return err
		}
	}

	if strings.Contains(input, "Dockerfile") {
		inputContent, err := utils.ReadPolicyFile(input)
		if err != nil {
			log.Errorf("Error reading input: %v", err)
		}

		dockerfileContent := parser.ParseDockerfileContent(string(inputContent))
		dockerfileJSON, err := json.Marshal(dockerfileContent)
		if err != nil {
			log.Errorf("Error marshaling Dockerfile: %v", err)
			return err
		}

		err = json.Indent(&prettyJSON, dockerfileJSON, "", "    ")
		if err != nil {
			log.Errorf("Error: %v", err)
			return err
		}
	}

	if prettyJSON.Len() == 0 {
		log.Errorf("The input: %v, must contain .tf extension or Dockerfile", input)
		return errors.New("input must contain .tf extension or Dockerfile")
	}

	log.Infof("JSON representation of %v: \n%v\n", input, prettyJSON.String())
	return nil
}

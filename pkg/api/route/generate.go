package route

import (
	"io"
	"net/http"

	"github.com/gin-gonic/gin"
	generate "github.com/intelops/genval/pkg/generate/dockerfile-gen"
	"github.com/intelops/genval/pkg/parser"
	validate "github.com/intelops/genval/pkg/validate/dockerfile-val"
	log "github.com/sirupsen/logrus"
)

func GenerateEndpoint(ctx *gin.Context) {
	log.Println("Request Headers:")
	for key, value := range ctx.Request.Header {
		log.Printf("%s: %s\n", key, value)
	}
	body, err := io.ReadAll(ctx.Request.Body)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Failed to read request body"})
		log.Infof("This is Request Header: %v", ctx.Request.Header)
		return
	}

	yamlContent := string(body)

	// Validate the input using OPA
	err = validate.ValidateJSON(yamlContent, validate.InputPolicy)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Validation error", "message": err.Error()})
		return
	}

	var data generate.DockerfileContent

	// ReadAndParseFile parses the body into DockerfileContent struct
	err = parser.ParseRequestBody(body, &data)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Failed to parse YAML content", "message": err.Error()})
		return
	}

	// Generate the Dockerfile
	dockerfileContent := generate.GenerateDockerfileContent(&data)

	// Validate the generated Dockerfile using OPA/Rego policies
	err = validate.ValidateDockerfile(dockerfileContent, validate.DockerfilePolicy)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Dockerfile validation failed", "message": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, gin.H{"message": "Dockerfile validation succeeded!", "dockerfile": dockerfileContent})

}

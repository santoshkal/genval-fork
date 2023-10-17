package route

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type CuevalRequest struct {
	Resource string `json:"resource" binding:"required"`
	Value    string `json:"value" binding:"required"`
}

func CuevalEndpoint(ctx *gin.Context) {
	var requestData CuevalRequest
	if err := ctx.ShouldBindJSON(&requestData); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Here, requestData.Resource and requestData.Value contain the data from the client request.
	resource := requestData.Resource
	value := requestData.Value

	// You can then use the 'resource' and 'value' in the rest of your logic.
	//Update the call to Execute() prepending the package name
	result, err := cueval.Execute(resource, value)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to validate and generate YAML", "details": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, gin.H{"message": "Validation succeeded!", "yaml": result})
}

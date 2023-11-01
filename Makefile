build: ## builds the GenVal app for defined OS/Arch by passing GOOS=$(GOOS) GOARCH=$GOARCH args.| Example usage `make build GOOS=linux GOARCH=amd64`
	@GOOS=$(GOOS) GOARCH=$(GOARCH) go build -ldflags="-X main.Version=$(shell git describe --tags --abbrev=0)" -o ./genval

format: ## Format the source code
	@echo "Formatting code..."
	@gofmt -s -w .

vet: ## Vet the Go code for potential issues
	@echo "Vetting code for potential issues..."
	@go vet $(PKGS)
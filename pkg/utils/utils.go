package utils

import (
	"fmt"
	"io"
	"io/fs"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
	log "github.com/sirupsen/logrus"
)

// TempDirWithCleanup creates a temporary directory and returns its path along with a cleanup function.
func TempDirWithCleanup() (dirPath string, cleanupFunc func(), err error) {
	td, err := os.MkdirTemp("", "")
	if err != nil {
		log.Fatal(err)
		return "", nil, err
	}
	return td, func() {
		os.RemoveAll(td)
	}, nil
}

func GenerateOverlay(staticFS fs.FS, td string, additionalFiles []string) (map[string]load.Source, error) {
	overlay := make(map[string]load.Source)

	// Walk through and add files from the embedded fs
	err := fs.WalkDir(staticFS, ".", func(p string, d fs.DirEntry, err error) error {
		if err != nil {
			return err
		}
		if !d.Type().IsRegular() {
			return nil
		}
		f, err := staticFS.Open(p)
		if err != nil {
			return err
		}
		byts, err := io.ReadAll(f)
		if err != nil {
			return err
		}
		op := filepath.Join(td, p)
		overlay[op] = load.FromBytes(byts)
		return nil
	})
	if err != nil {
		return nil, err
	}

	// Add files from additionalFiles
	for _, filePath := range additionalFiles {
		fileBytes, err := ReadPolicyFile(filePath)
		if err != nil {
			log.Errorf("Error reading schema:%v", err)
			return nil, err
		}
		overlay[filepath.Join(td, filepath.Base(filePath))] = load.FromBytes(fileBytes)
	}

	return overlay, nil
}

func toCamelCase(s string) string {
	return strings.ToLower(s[:1]) + s[1:]
}

// ReadAndCompileData reads the content from the given file path and compiles it using CUE.
func ReadAndCompileData(defPath string, dataFile string) (titleCaseDefPath string, data cue.Value, err error) {
	ds, err := os.ReadFile(dataFile)
	if err != nil {
		return "", cue.Value{}, err
	}

	ctx := cuecontext.New()
	compiledData := ctx.CompileBytes(ds)
	if compiledData.Err() != nil {
		return "", cue.Value{}, compiledData.Err()
	}

	titleCaseDefPath = toCamelCase(defPath)
	return titleCaseDefPath, compiledData, nil
}

func ReadSchemaFile(schema string) []byte {
	schemaData, err := os.ReadFile(schema)
	if err != nil {
		log.Fatalf("Error reading schema:%v", err)
	}
	return schemaData

}

func ReadPolicyFile(policyFile string) ([]byte, error) {
	// Attempt to parse the policyFile as a URL
	u, err := url.ParseRequestURI(policyFile)
	if err == nil && u.Scheme != "" && u.Host != "" {
		// It's a URL, fetch content
		resp, err := http.Get(u.String())
		if err != nil {
			log.Errorf("error fetching Rego policy from URL: %v", err)
			return nil, err
		}
		defer resp.Body.Close()

		if resp.StatusCode != http.StatusOK {
			log.Errorf("error fetching Rego policy from URL: status code %d", resp.StatusCode)
			return nil, err
		}

		policyContent, err := io.ReadAll(resp.Body)
		if err != nil {
			log.Errorf("error reading Rego policy from URL: %v", err)
			return nil, err
		}

		return policyContent, nil
	} else {
		// If not a URL, treat it as a local file path
		policyContent, err := os.ReadFile(policyFile)
		if err != nil {
			log.Errorf("error reading policy from file: %v", err)
			return nil, err
		}

		return policyContent, nil
	}
}

func CopyFilesToTempDir(filesToCopy []string) (string, []string, error) {
	// Create a temporary directory
	tempDir, err := os.MkdirTemp("/tmp", "")
	if err != nil {
		return "", nil, err
	}
	fmt.Println("Temporary Directory:", tempDir)

	// Create a slice to store the paths of copied files
	copiedFilePaths := []string{}

	// Loop through the file paths and copy them to the temporary directory
	for _, filePath := range filesToCopy {
		fileContent, err := os.ReadFile(filePath)
		if err != nil {
			return "", nil, err
		}

		destPath := filepath.Join(tempDir, filepath.Base(filePath))
		err = os.WriteFile(destPath, fileContent, 0644)
		if err != nil {
			return "", nil, err
		}

		fmt.Printf("Copied %s to %s\n", filePath, destPath)

		// Add the copied file's path to the slice
		copiedFilePaths = append(copiedFilePaths, destPath)

		// fmt.Printf("Length of CopiedPaths %v\n", len(copiedFilePaths))

		// defer os.RemoveAll(tempDir) // Clean up the temporary directory when done
	}

	// Return the temporary directory path and the paths of copied files
	return tempDir, copiedFilePaths, nil
}
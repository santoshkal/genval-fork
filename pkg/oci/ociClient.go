package oci

//TODO: Change Package name

import (
	"archive/tar"
	"compress/gzip"
	"fmt"
	"io"
	"io/fs"
	"os"
	"path/filepath"
	"strings"
	"time"

	"github.com/google/go-containerregistry/pkg/name"
)

// createTarball creates a tarball from a file or directory.
func CreateTarball(sourcePath, outputPath string) error {
	outputFile, err := os.Create(outputPath)
	if err != nil {
		return err
	}

	gzipWriter := gzip.NewWriter(outputFile)
	defer gzipWriter.Close()

	tarWriter := tar.NewWriter(gzipWriter)
	defer tarWriter.Close()

	if err := filepath.WalkDir(sourcePath, func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			return err
		}

		info, err := d.Info()
		if err != nil {
			return err
		}

		header, err := tar.FileInfoHeader(info, "")
		if err != nil {
			return err
		}

		// Strip environment-specific data from file headers
		header.Gid = 0
		header.Uid = 0
		header.Uname = ""
		header.Gname = ""
		header.ModTime = time.Time{}
		header.AccessTime = time.Time{}
		header.ChangeTime = time.Time{}

		if err := tarWriter.WriteHeader(header); err != nil {
			return err
		}

		if info.IsDir() {
			return nil
		}

		file, err := os.Open(path)
		if err != nil {
			return err
		}
		defer file.Close()

		// Copy file content to tarball
		_, err = io.Copy(tarWriter, file)
		return err
	}); err != nil {
		outputFile.Close()
		gzipWriter.Close()
		tarWriter.Close()
		return nil
	}
	return err
}

// ParseSourcetURL validates the OCI URL and returns the address of the artifact.
func ParseSourcetURL(ociURL string) (string, error) {
	if !strings.HasPrefix(ociURL, OCIRepoPrefix) {
		return "", fmt.Errorf("URL must be in format 'oci://<domain>/<org>/<repo>'")
	}

	url := strings.TrimPrefix(ociURL, OCIRepoPrefix)
	if _, err := name.ParseReference(url); err != nil {
		return "", fmt.Errorf("'%s' invalid URL: %w", ociURL, err)
	}

	return url, nil
}

// func Options(ctx context.Context, creds string) []crane.Option {
// 	var opts []crane.Option

// 	opts = append(opts, crane.WithUserAgent(UserAgent), crane.WithContext(ctx))
// 	if creds != "" {
// 		var authConfig authn.AuthConfig

// 	}
// }

package cmd

import (
	"fmt"
	"os"
	"strings"

	"github.com/google/go-containerregistry/pkg/authn"
	"github.com/google/go-containerregistry/pkg/compression"
	"github.com/google/go-containerregistry/pkg/crane"
	"github.com/google/go-containerregistry/pkg/name"
	v1 "github.com/google/go-containerregistry/pkg/v1"
	"github.com/google/go-containerregistry/pkg/v1/empty"
	"github.com/google/go-containerregistry/pkg/v1/mutate"
	"github.com/google/go-containerregistry/pkg/v1/tarball"
	"github.com/google/go-containerregistry/pkg/v1/types"
	"github.com/intelops/genval/pkg/oci"
	"github.com/intelops/genval/pkg/utils"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

var pushCmd = &cobra.Command{
	Use:   "push",
	Short: "The artifact push command pushes the tar.gz bundle to an OCI complient container registry",
	Long: `
	The artifact push command takes in a tar.gz bundle of configuration files generated/validated by Genval
and pushes them into a OCI complient container registry
`,
	Example: `
# push the generated/validated set of files in to a OCI bundle

genval artifact push --reqinput <path to tar.gz> \
--url <url for OCI registry>
`,
	RunE: runPushCmd,
}

type pushFlags struct {
	reqinput    string
	source      string
	annotations []string
	tag         string
	sign        string
}

var pushArgs pushFlags

func init() {
	pushCmd.Flags().StringVarP(&pushArgs.reqinput, "reqinput", "r", "", "path to the artifact (tar.gz) source files to push")
	if err := pushCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	pushCmd.Flags().StringVarP(&pushArgs.source, "source", "s", ".", "Source URl for the registry")
	if err := pushCmd.MarkFlagRequired("url"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	pushCmd.Flags().StringArrayVarP(&pushArgs.annotations, "annotations", "a", nil, "Set custom annotation in <key>=<value> format")
	pushCmd.Flags().StringVarP(&pushArgs.tag, "tag", "t", "", "update the artifact with a tag")
	pushCmd.Flags().StringVarP(&pushArgs.sign, "sign", "s", "", "Sign the artifact with Cosign")
	artifactCmd.AddCommand(pushCmd)
}

func runPushCmd(cmd *cobra.Command, args []string) error {
	if pushArgs.reqinput == "" || pushArgs.source == "" {
		log.Printf("Required args mising")
	}

	inputPath := pushArgs.reqinput
	source := pushArgs.source
	// tag := pushArgs.tag
	// sign := pushArgs.sign
	// annotations := pushArgs.annotations

	if err := utils.CheckPathExists(inputPath); err != nil {
		log.Errorf("Error reading %s: %v\n", inputPath, err)
		os.Exit(1)
	}

	outputPath, err := os.MkdirTemp("", "artifacts.tar.gz")
	if err != nil {
		log.Printf("Error creating Temp dir: %v", err)
	}
	defer os.RemoveAll(outputPath)

	log.Printf("✔ Building artifact from: %v", inputPath)

	// Create a tarball from the input path
	if err := oci.CreateTarball(inputPath, outputPath); err != nil {
		return fmt.Errorf("creating tarball: %w", err)
	}
	log.Println("✔ Artifact created successfully")

	url, err := oci.ParseSourcetURL(source)
	if err != nil {
		log.Printf("Error parsing source: %v", err)
	}

	ref, err := name.ParseReference(url)
	if err != nil {
		return err
	}

	annotations := map[string]string{}
	for _, annotation := range pushArgs.annotations {
		kv := strings.Split(annotation, "=")
		if len(kv) != 2 {
			return fmt.Errorf("invalid annotation %s, must be in the format key=value", annotation)
		}
		annotations[kv[0]] = kv[1]
	}

	img := mutate.MediaType(empty.Image, types.OCIManifestSchema1)
	img = mutate.ConfigMediaType(img, oci.ConfigMediaType)
	img = mutate.Annotations(img, annotations).(v1.Image)

	layer, err := tarball.LayerFromFile(ref.String(),
		tarball.WithMediaType(oci.ContentMediaType),
		tarball.WithCompression(compression.GZip),
		tarball.WithCompressedCaching)

	if err != nil {
		log.Errorf("Creating content layer failed: %v", err)
	}

	img, err = mutate.Append(img, mutate.Addendum{
		Layer: layer,
		Annotations: map[string]string{
			oci.ContentTypeAnnotation: "",
		},
	})

	if err != nil {
		log.Errorf("appending content to artifact failed: %w", err)
	}

	opts := crane.WithAuthFromKeychain((authn.DefaultKeychain))

	if err := crane.Push(img, ref.String(), opts); err != nil {
		log.Fatalf("Error pushing artifact: %v", err)
	}

	return nil
}

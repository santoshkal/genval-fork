package cueval

import (
	"fmt"
	"os"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
	embeder "github.com/intelops/genval"
	"github.com/intelops/genval/pkg/cuecore"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	log "github.com/sirupsen/logrus"
)

func init() {
	log.SetFormatter(&log.TextFormatter{
		FullTimestamp: false,
		FieldMap: log.FieldMap{
			log.FieldKeyTime:  "@timestamp",
			log.FieldKeyLevel: "@level",
			log.FieldKeyMsg:   "@message",
		},
	})
}

func Execute(resource string, reqinput string, policies ...string) {
	const modPath = "github.com/intelops/genval"
	staticFS := embeder.CueDef

	td, cleanup, err := utils.TempDirWithCleanup()
	if err != nil {
		log.Fatal(err)
	}
	defer cleanup()

	ctx := cuecontext.New()

	if resource == "" || reqinput == "" || len(policies) == 0 {
		fmt.Println("[Usage]: genval --mode=cue --resource=<Resource> --reqinput=<Input JSON> --policy <path/to/.cue schema file")
		return
	}

	defPath := resource
	dataFile := reqinput
	schemaFile := policies

	overlay, err := utils.GenerateOverlay(staticFS, td, schemaFile)
	if err != nil {
		log.Fatal(err)
	}

	conf := &load.Config{
		Overlay: overlay,
		Module:  modPath,
		Package: "*",
	}

	res, data, err := utils.ReadAndCompileData(defPath, dataFile)
	if err != nil {
		log.Fatalf("Error processing data: %v", err)
		return
	}

	defName := "#" + defPath
	allOverlays := map[string]load.Source{}

	conf = &load.Config{
		Overlay: overlay,
		Module:  modPath,
		Package: "*",
	}

	var unifiedPolicy cue.Value
	firstPolicy := true
	v, err := cuecore.BuildInstance(ctx, policies, conf)
	if err != nil {
		log.Fatal(err)
	}
	overlay, err = utils.GenerateOverlay(staticFS, td, policies)
	if err != nil {
		log.Fatal(err)
	}
	for k, v := range overlay {
		allOverlays[k] = v
	}
	conf.Overlay = overlay

	for _, policyPath := range policies {
		if len(v) == 0 {
			log.Fatal("No instances found for policy: ", policyPath)
		}

		if firstPolicy {
			unifiedPolicy = v[0]
		} else {
			unifiedPolicy = unifiedPolicy.Unify(v[0])
			if unifiedPolicy.Err() != nil {
				log.Fatalf("Error unifying policies: %v", unifiedPolicy.Err())
				return
			}
		}
	}
	conf.Overlay = allOverlays

	lookUp := cue.ParsePath(defName)
	def := unifiedPolicy.LookupPath(lookUp)
	if def.Err() != nil {
		log.Errorf("Error parsing Path: %v", def.Err())
		return
	}

	unifiedValue, err := cuecore.UnifyAndValidate(def, data)
	if err != nil {
		log.Errorf("Validation failed: %v", err)
		return
	}

	yamlData, err := parser.CueToYAML(unifiedValue)
	if err != nil {
		log.Errorf("Error Marshaling: %v", err)
		return
	}

	err = os.WriteFile(res+".yaml", yamlData, 0644)
	if err != nil {
		log.Errorf("Writing YAML: %v", err)
		return
	}

	fmt.Printf("%v validation succeeded, generated manifest: %v.yaml\n", defPath, res)
}

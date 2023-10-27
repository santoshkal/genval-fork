package cuecore

import (
	"fmt"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/load"
	log "github.com/sirupsen/logrus"
	"gopkg.in/yaml.v3"
)

func BuildInstance(ctx *cue.Context, td []string, conf *load.Config) ([]cue.Value, error) {
	var err error
	bi := load.Instances(td, conf)
	if len(bi) == 0 {
		return nil, fmt.Errorf("no instances found")
	}
	v, err := ctx.BuildInstances(bi)
	if err != nil {
		log.Errorf("Error building instances: %v", err)
	}
	return v, err
}

func UnifyAndValidate(def cue.Value, data cue.Value) (cue.Value, error) {
	value := def.Unify(data)
	if value.Err() != nil {
		return cue.Value{}, value.Err()
	}

	err := value.Validate(cue.Concrete(false), cue.Final())
	if err != nil {
		return cue.Value{}, err
	}
	return value, nil
}

func MarshalToYAML(value cue.Value) ([]byte, error) {
	o, err := value.MarshalJSON()
	if err != nil {
		return nil, err
	}

	var output map[string]interface{}
	err = yaml.Unmarshal(o, &output)
	if err != nil {
		return nil, err
	}

	return yaml.Marshal(output)
}

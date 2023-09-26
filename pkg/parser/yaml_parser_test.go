package parser

import (
	"reflect"
	"testing"
)

func TestParseYAMLContent(t *testing.T) {
	type args struct {
		yamlContent string
	}
	tests := []struct {
		name    string
		args    args
		want    *InputYAML
		wantErr bool
	}{
		// TODO: Add test cases.
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := ParseYAMLContent(tt.args.yamlContent)
			if (err != nil) != tt.wantErr {
				t.Errorf("ParseYAMLContent() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			if !reflect.DeepEqual(got, tt.want) {
				t.Errorf("ParseYAMLContent() = %v, want %v", got, tt.want)
			}
		})
	}
}

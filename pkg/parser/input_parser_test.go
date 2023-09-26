package parser

import "testing"

func TestReadAndParseFile(t *testing.T) {
	type args struct {
		filename string
		data     interface{}
	}
	tests := []struct {
		name    string
		args    args
		wantErr bool
	}{
		// TODO: Add test cases.
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if err := ReadAndParseFile(tt.args.filename, tt.args.data); (err != nil) != tt.wantErr {
				t.Errorf("ReadAndParseFile() error = %v, wantErr %v", err, tt.wantErr)
			}
		})
	}
}

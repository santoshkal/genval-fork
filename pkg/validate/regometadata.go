package validate

type regoMetadata struct {
	Name        string `json:"name"`
	PolicyName  string `json:"policy_name"`
	PolicyFile  string `json:"policy_file"`
	Severity    string `json:"severity"`
	Description string `json:"description"`
	Benchmark   string `json:"benchmark"`
	Category    string `json:"category"`
}

const (
	metaExt   = ".json"
	policyExt = ".rego"
)

type CELPolicy struct {
	APIVersion  string `yaml:"apiVersion"`
	Name        string `yaml:"name"`
	Description string `yaml:"description"`
	Severity    string `yaml:"severity"`
	Benchmark   string `yaml:"benchmark"`
	Rule        string `yaml:"rule"`
}

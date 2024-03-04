package oci

const (
	OCIRepoPrefix = "oci://"

	// UserAgent is the agent name used for OpenContainers artifact operations.
	UserAgent = "genval/v1"

	// SourceAnnotation is the OpenContainers annotation for specifying
	// the upstream source of an OCI artifact.
	SourceAnnotation = "org.opencontainers.image.source"

	// RevisionAnnotation is the OpenContainers annotation for specifying
	// the upstream source revision of an OCI artifact.
	RevisionAnnotation = "org.opencontainers.image.revision"

	// CreatedAnnotation is the OpenContainers annotation for specifying
	// the date and time on which the OCI artifact was built (RFC 3339).
	CreatedAnnotation = "org.opencontainers.image.created"

	// ConfigMediaType is the OpenContainers artifact media type for the config layer.
	ConfigMediaType = "application/vnd.genval.config.v1+json"

	// ContentMediaType is the OpenContainers artifact media type for the content layer.
	ContentMediaType = "application/vnd.timoni.content.v1.tar+gzip"

	ContentTypeAnnotation = "genval.content.type"
)

type Metadata struct {
	Created     string            `json:"created,omitempty"`
	Source      string            `json:"source_url,omitempty"`
	Revision    string            `json:"source_revision,omitempty"`
	Digest      string            `json:"digest"`
	URL         string            `json:"url"`
	Annotations map[string]string `json:"annotations,omitempty"`
}

// ToAnnotations returns the OpenContainers annotations map.
func (m *Metadata) ToAnnotations() map[string]string {
	annotations := map[string]string{
		CreatedAnnotation:  m.Created,
		SourceAnnotation:   m.Source,
		RevisionAnnotation: m.Revision,
	}

	for k, v := range m.Annotations {
		annotations[k] = v
	}

	return annotations
}

// MetadataFromAnnotations parses the OpenContainers annotations and returns a Metadata object.
func MetadataFromAnnotations(annotations map[string]string) *Metadata {
	return &Metadata{
		Created:     annotations[CreatedAnnotation],
		Source:      annotations[SourceAnnotation],
		Revision:    annotations[RevisionAnnotation],
		Annotations: annotations,
	}
}

// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/crossplane/crossplane/apis/pkg/meta/v1

package v1

// MetaSpec are fields that every meta package type must implement.
#MetaSpec: {
	// Semantic version constraints of Crossplane that package is compatible with.
	crossplane?: null | #CrossplaneConstraints @go(Crossplane,*CrossplaneConstraints)

	// Dependencies on other packages.
	dependsOn?: [...#Dependency] @go(DependsOn,[]Dependency)
}

// CrossplaneConstraints specifies a packages compatibility with Crossplane versions.
#CrossplaneConstraints: {
	// Semantic version constraints of Crossplane that package is compatible with.
	version: string @go(Version)
}

// Dependency is a dependency on another package. One of Provider or Configuration may be supplied.
#Dependency: {
	// Provider is the name of a Provider package image.
	provider?: null | string @go(Provider,*string)

	// Configuration is the name of a Configuration package image.
	configuration?: null | string @go(Configuration,*string)

	// Version is the semantic version constraints of the dependency image.
	version: string @go(Version)
}
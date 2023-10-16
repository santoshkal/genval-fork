// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/appsync/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#APIKeyInitParameters: {
	// API key description.
	description?: null | string @go(Description,*string)

	// RFC3339 string representation of the expiry date. Rounded down to nearest hour. By default, it is 7 days from the date of creation.
	expires?: null | string @go(Expires,*string)
}

#APIKeyObservation: {
	// ID of the associated AppSync API
	apiId?: null | string @go(APIID,*string)

	// API key description.
	description?: null | string @go(Description,*string)

	// RFC3339 string representation of the expiry date. Rounded down to nearest hour. By default, it is 7 days from the date of creation.
	expires?: null | string @go(Expires,*string)

	// API Key ID (Formatted as ApiId:Key)
	id?: null | string @go(ID,*string)
}

#APIKeyParameters: {
	// ID of the associated AppSync API
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/appsync/v1beta1.GraphQLAPI
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	apiId?: null | string @go(APIID,*string)

	// Reference to a GraphQLAPI in appsync to populate apiId.
	// +kubebuilder:validation:Optional
	apiIdRef?: null | v1.#Reference @go(APIIDRef,*v1.Reference)

	// Selector for a GraphQLAPI in appsync to populate apiId.
	// +kubebuilder:validation:Optional
	apiIdSelector?: null | v1.#Selector @go(APIIDSelector,*v1.Selector)

	// API key description.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// RFC3339 string representation of the expiry date. Rounded down to nearest hour. By default, it is 7 days from the date of creation.
	// +kubebuilder:validation:Optional
	expires?: null | string @go(Expires,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// APIKeySpec defines the desired state of APIKey
#APIKeySpec: {
	v1.#ResourceSpec
	forProvider: #APIKeyParameters @go(ForProvider)

	// THIS IS A BETA FIELD. It will be honored
	// unless the Management Policies feature flag is disabled.
	// InitProvider holds the same fields as ForProvider, with the exception
	// of Identifier and other resource reference fields. The fields that are
	// in InitProvider are merged into ForProvider when the resource is created.
	// The same fields are also added to the terraform ignore_changes hook, to
	// avoid updating them after creation. This is useful for fields that are
	// required on creation, but we do not desire to update them after creation,
	// for example because of an external controller is managing them, like an
	// autoscaler.
	initProvider?: #APIKeyInitParameters @go(InitProvider)
}

// APIKeyStatus defines the observed state of APIKey.
#APIKeyStatus: {
	v1.#ResourceStatus
	atProvider?: #APIKeyObservation @go(AtProvider)
}

// APIKey is the Schema for the APIKeys API. Provides an AppSync API Key.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#APIKey: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #APIKeySpec        @go(Spec)
	status?:   #APIKeyStatus      @go(Status)
}

// APIKeyList contains a list of APIKeys
#APIKeyList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#APIKey] @go(Items,[]APIKey)
}
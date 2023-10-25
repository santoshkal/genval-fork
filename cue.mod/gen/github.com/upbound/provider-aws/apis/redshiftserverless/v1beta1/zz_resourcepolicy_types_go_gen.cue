// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/redshiftserverless/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ResourcePolicyInitParameters: {
	// The policy to create or update. For example, the following policy grants a user authorization to restore a snapshot.
	policy?: null | string @go(Policy,*string)
}

#ResourcePolicyObservation: {
	// The Amazon Resource Name (ARN) of the account to create or update a resource policy for.
	id?: null | string @go(ID,*string)

	// The policy to create or update. For example, the following policy grants a user authorization to restore a snapshot.
	policy?: null | string @go(Policy,*string)

	// The Amazon Resource Name (ARN) of the account to create or update a resource policy for.
	resourceArn?: null | string @go(ResourceArn,*string)
}

#ResourcePolicyParameters: {
	// The policy to create or update. For example, the following policy grants a user authorization to restore a snapshot.
	// +kubebuilder:validation:Optional
	policy?: null | string @go(Policy,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The Amazon Resource Name (ARN) of the account to create or update a resource policy for.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/redshiftserverless/v1beta1.Snapshot
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	resourceArn?: null | string @go(ResourceArn,*string)

	// Reference to a Snapshot in redshiftserverless to populate resourceArn.
	// +kubebuilder:validation:Optional
	resourceArnRef?: null | v1.#Reference @go(ResourceArnRef,*v1.Reference)

	// Selector for a Snapshot in redshiftserverless to populate resourceArn.
	// +kubebuilder:validation:Optional
	resourceArnSelector?: null | v1.#Selector @go(ResourceArnSelector,*v1.Selector)
}

// ResourcePolicySpec defines the desired state of ResourcePolicy
#ResourcePolicySpec: {
	v1.#ResourceSpec
	forProvider: #ResourcePolicyParameters @go(ForProvider)

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
	initProvider?: #ResourcePolicyInitParameters @go(InitProvider)
}

// ResourcePolicyStatus defines the observed state of ResourcePolicy.
#ResourcePolicyStatus: {
	v1.#ResourceStatus
	atProvider?: #ResourcePolicyObservation @go(AtProvider)
}

// ResourcePolicy is the Schema for the ResourcePolicys API. Provides a Redshift Serverless Resource Policy resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ResourcePolicy: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.policy) || (has(self.initProvider) && has(self.initProvider.policy))",message="spec.forProvider.policy is a required parameter"
	spec:    #ResourcePolicySpec   @go(Spec)
	status?: #ResourcePolicyStatus @go(Status)
}

// ResourcePolicyList contains a list of ResourcePolicys
#ResourcePolicyList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ResourcePolicy] @go(Items,[]ResourcePolicy)
}
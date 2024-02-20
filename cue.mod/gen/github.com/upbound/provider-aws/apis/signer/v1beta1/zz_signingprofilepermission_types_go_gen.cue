// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/signer/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#SigningProfilePermissionInitParameters: {
	// An AWS Signer action permitted as part of cross-account permissions. Valid values: signer:StartSigningJob, signer:GetSigningProfile, or signer:RevokeSignature.
	action?: null | string @go(Action,*string)

	// The AWS principal to be granted a cross-account permission.
	principal?: null | string @go(Principal,*string)

	// A statement identifier prefix. Conflicts with statement_id.
	statementIdPrefix?: null | string @go(StatementIDPrefix,*string)
}

#SigningProfilePermissionObservation: {
	// An AWS Signer action permitted as part of cross-account permissions. Valid values: signer:StartSigningJob, signer:GetSigningProfile, or signer:RevokeSignature.
	action?: null | string @go(Action,*string)
	id?:     null | string @go(ID,*string)

	// The AWS principal to be granted a cross-account permission.
	principal?: null | string @go(Principal,*string)

	// Name of the signing profile to add the cross-account permissions.
	profileName?: null | string @go(ProfileName,*string)

	// The signing profile version that a permission applies to.
	profileVersion?: null | string @go(ProfileVersion,*string)

	// A unique statement identifier.
	statementId?: null | string @go(StatementID,*string)

	// A statement identifier prefix. Conflicts with statement_id.
	statementIdPrefix?: null | string @go(StatementIDPrefix,*string)
}

#SigningProfilePermissionParameters: {
	// An AWS Signer action permitted as part of cross-account permissions. Valid values: signer:StartSigningJob, signer:GetSigningProfile, or signer:RevokeSignature.
	// +kubebuilder:validation:Optional
	action?: null | string @go(Action,*string)

	// The AWS principal to be granted a cross-account permission.
	// +kubebuilder:validation:Optional
	principal?: null | string @go(Principal,*string)

	// Name of the signing profile to add the cross-account permissions.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/signer/v1beta1.SigningProfile
	// +kubebuilder:validation:Optional
	profileName?: null | string @go(ProfileName,*string)

	// Reference to a SigningProfile in signer to populate profileName.
	// +kubebuilder:validation:Optional
	profileNameRef?: null | v1.#Reference @go(ProfileNameRef,*v1.Reference)

	// Selector for a SigningProfile in signer to populate profileName.
	// +kubebuilder:validation:Optional
	profileNameSelector?: null | v1.#Selector @go(ProfileNameSelector,*v1.Selector)

	// The signing profile version that a permission applies to.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/signer/v1beta1.SigningProfile
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("version",true)
	// +kubebuilder:validation:Optional
	profileVersion?: null | string @go(ProfileVersion,*string)

	// Reference to a SigningProfile in signer to populate profileVersion.
	// +kubebuilder:validation:Optional
	profileVersionRef?: null | v1.#Reference @go(ProfileVersionRef,*v1.Reference)

	// Selector for a SigningProfile in signer to populate profileVersion.
	// +kubebuilder:validation:Optional
	profileVersionSelector?: null | v1.#Selector @go(ProfileVersionSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// A unique statement identifier.
	// +kubebuilder:validation:Optional
	statementId?: null | string @go(StatementID,*string)

	// A statement identifier prefix. Conflicts with statement_id.
	// +kubebuilder:validation:Optional
	statementIdPrefix?: null | string @go(StatementIDPrefix,*string)
}

// SigningProfilePermissionSpec defines the desired state of SigningProfilePermission
#SigningProfilePermissionSpec: {
	v1.#ResourceSpec
	forProvider: #SigningProfilePermissionParameters @go(ForProvider)

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
	initProvider?: #SigningProfilePermissionInitParameters @go(InitProvider)
}

// SigningProfilePermissionStatus defines the observed state of SigningProfilePermission.
#SigningProfilePermissionStatus: {
	v1.#ResourceStatus
	atProvider?: #SigningProfilePermissionObservation @go(AtProvider)
}

// SigningProfilePermission is the Schema for the SigningProfilePermissions API. Creates a Signer Signing Profile Permission.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#SigningProfilePermission: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.action) || (has(self.initProvider) && has(self.initProvider.action))",message="spec.forProvider.action is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.principal) || (has(self.initProvider) && has(self.initProvider.principal))",message="spec.forProvider.principal is a required parameter"
	spec:    #SigningProfilePermissionSpec   @go(Spec)
	status?: #SigningProfilePermissionStatus @go(Status)
}

// SigningProfilePermissionList contains a list of SigningProfilePermissions
#SigningProfilePermissionList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#SigningProfilePermission] @go(Items,[]SigningProfilePermission)
}
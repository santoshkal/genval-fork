// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/cognitoidentity/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#MappingRuleInitParameters: {
	// The claim name that must be present in the token, for example, "isAdmin" or "paid".
	claim?: null | string @go(Claim,*string)

	// The match condition that specifies how closely the claim value in the IdP token must match Value.
	matchType?: null | string @go(MatchType,*string)

	// A brief string that the claim must match, for example, "paid" or "yes".
	value?: null | string @go(Value,*string)
}

#MappingRuleObservation: {
	// The claim name that must be present in the token, for example, "isAdmin" or "paid".
	claim?: null | string @go(Claim,*string)

	// The match condition that specifies how closely the claim value in the IdP token must match Value.
	matchType?: null | string @go(MatchType,*string)

	// The role ARN.
	roleArn?: null | string @go(RoleArn,*string)

	// A brief string that the claim must match, for example, "paid" or "yes".
	value?: null | string @go(Value,*string)
}

#MappingRuleParameters: {
	// The claim name that must be present in the token, for example, "isAdmin" or "paid".
	// +kubebuilder:validation:Optional
	claim?: null | string @go(Claim,*string)

	// The match condition that specifies how closely the claim value in the IdP token must match Value.
	// +kubebuilder:validation:Optional
	matchType?: null | string @go(MatchType,*string)

	// The role ARN.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/iam/v1beta1.Role
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	roleArn?: null | string @go(RoleArn,*string)

	// Reference to a Role in iam to populate roleArn.
	// +kubebuilder:validation:Optional
	roleArnRef?: null | v1.#Reference @go(RoleArnRef,*v1.Reference)

	// Selector for a Role in iam to populate roleArn.
	// +kubebuilder:validation:Optional
	roleArnSelector?: null | v1.#Selector @go(RoleArnSelector,*v1.Selector)

	// A brief string that the claim must match, for example, "paid" or "yes".
	// +kubebuilder:validation:Optional
	value?: null | string @go(Value,*string)
}

#PoolRolesAttachmentInitParameters: {
	// A List of Role Mapping.
	roleMapping?: [...#RoleMappingInitParameters] @go(RoleMapping,[]RoleMappingInitParameters)

	// The map of roles associated with this pool. For a given role, the key will be either "authenticated" or "unauthenticated" and the value will be the Role ARN.
	roles?: {[string]: null | string} @go(Roles,map[string]*string)
}

#PoolRolesAttachmentObservation: {
	// The identity pool ID.
	id?: null | string @go(ID,*string)

	// An identity pool ID in the format REGION_GUID.
	identityPoolId?: null | string @go(IdentityPoolID,*string)

	// A List of Role Mapping.
	roleMapping?: [...#RoleMappingObservation] @go(RoleMapping,[]RoleMappingObservation)

	// The map of roles associated with this pool. For a given role, the key will be either "authenticated" or "unauthenticated" and the value will be the Role ARN.
	roles?: {[string]: null | string} @go(Roles,map[string]*string)
}

#PoolRolesAttachmentParameters: {
	// An identity pool ID in the format REGION_GUID.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/cognitoidentity/v1beta1.Pool
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	identityPoolId?: null | string @go(IdentityPoolID,*string)

	// Reference to a Pool in cognitoidentity to populate identityPoolId.
	// +kubebuilder:validation:Optional
	identityPoolIdRef?: null | v1.#Reference @go(IdentityPoolIDRef,*v1.Reference)

	// Selector for a Pool in cognitoidentity to populate identityPoolId.
	// +kubebuilder:validation:Optional
	identityPoolIdSelector?: null | v1.#Selector @go(IdentityPoolIDSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// A List of Role Mapping.
	// +kubebuilder:validation:Optional
	roleMapping?: [...#RoleMappingParameters] @go(RoleMapping,[]RoleMappingParameters)

	// The map of roles associated with this pool. For a given role, the key will be either "authenticated" or "unauthenticated" and the value will be the Role ARN.
	// +kubebuilder:validation:Optional
	roles?: {[string]: null | string} @go(Roles,map[string]*string)
}

#RoleMappingInitParameters: {
	// Specifies the action to be taken if either no rules match the claim value for the Rules type, or there is no cognito:preferred_role claim and there are multiple cognito:roles matches for the Token type. Required if you specify Token or Rules as the Type.
	ambiguousRoleResolution?: null | string @go(AmbiguousRoleResolution,*string)

	// A string identifying the identity provider, for example, "graph.facebook.com" or "cognito-idp.us-east-1.amazonaws.com/us-east-1_abcdefghi:app_client_id". Depends on cognito_identity_providers set on aws_cognito_identity_pool resource or a aws_cognito_identity_provider resource.
	identityProvider?: null | string @go(IdentityProvider,*string)

	// The Rules Configuration to be used for mapping users to roles. You can specify up to 25 rules per identity provider. Rules are evaluated in order. The first one to match specifies the role.
	mappingRule?: [...#MappingRuleInitParameters] @go(MappingRule,[]MappingRuleInitParameters)

	// The role mapping type.
	type?: null | string @go(Type,*string)
}

#RoleMappingObservation: {
	// Specifies the action to be taken if either no rules match the claim value for the Rules type, or there is no cognito:preferred_role claim and there are multiple cognito:roles matches for the Token type. Required if you specify Token or Rules as the Type.
	ambiguousRoleResolution?: null | string @go(AmbiguousRoleResolution,*string)

	// A string identifying the identity provider, for example, "graph.facebook.com" or "cognito-idp.us-east-1.amazonaws.com/us-east-1_abcdefghi:app_client_id". Depends on cognito_identity_providers set on aws_cognito_identity_pool resource or a aws_cognito_identity_provider resource.
	identityProvider?: null | string @go(IdentityProvider,*string)

	// The Rules Configuration to be used for mapping users to roles. You can specify up to 25 rules per identity provider. Rules are evaluated in order. The first one to match specifies the role.
	mappingRule?: [...#MappingRuleObservation] @go(MappingRule,[]MappingRuleObservation)

	// The role mapping type.
	type?: null | string @go(Type,*string)
}

#RoleMappingParameters: {
	// Specifies the action to be taken if either no rules match the claim value for the Rules type, or there is no cognito:preferred_role claim and there are multiple cognito:roles matches for the Token type. Required if you specify Token or Rules as the Type.
	// +kubebuilder:validation:Optional
	ambiguousRoleResolution?: null | string @go(AmbiguousRoleResolution,*string)

	// A string identifying the identity provider, for example, "graph.facebook.com" or "cognito-idp.us-east-1.amazonaws.com/us-east-1_abcdefghi:app_client_id". Depends on cognito_identity_providers set on aws_cognito_identity_pool resource or a aws_cognito_identity_provider resource.
	// +kubebuilder:validation:Optional
	identityProvider?: null | string @go(IdentityProvider,*string)

	// The Rules Configuration to be used for mapping users to roles. You can specify up to 25 rules per identity provider. Rules are evaluated in order. The first one to match specifies the role.
	// +kubebuilder:validation:Optional
	mappingRule?: [...#MappingRuleParameters] @go(MappingRule,[]MappingRuleParameters)

	// The role mapping type.
	// +kubebuilder:validation:Optional
	type?: null | string @go(Type,*string)
}

// PoolRolesAttachmentSpec defines the desired state of PoolRolesAttachment
#PoolRolesAttachmentSpec: {
	v1.#ResourceSpec
	forProvider: #PoolRolesAttachmentParameters @go(ForProvider)

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
	initProvider?: #PoolRolesAttachmentInitParameters @go(InitProvider)
}

// PoolRolesAttachmentStatus defines the observed state of PoolRolesAttachment.
#PoolRolesAttachmentStatus: {
	v1.#ResourceStatus
	atProvider?: #PoolRolesAttachmentObservation @go(AtProvider)
}

// PoolRolesAttachment is the Schema for the PoolRolesAttachments API. Provides an AWS Cognito Identity Pool Roles Attachment.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#PoolRolesAttachment: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.roles) || (has(self.initProvider) && has(self.initProvider.roles))",message="spec.forProvider.roles is a required parameter"
	spec:    #PoolRolesAttachmentSpec   @go(Spec)
	status?: #PoolRolesAttachmentStatus @go(Status)
}

// PoolRolesAttachmentList contains a list of PoolRolesAttachments
#PoolRolesAttachmentList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#PoolRolesAttachment] @go(Items,[]PoolRolesAttachment)
}
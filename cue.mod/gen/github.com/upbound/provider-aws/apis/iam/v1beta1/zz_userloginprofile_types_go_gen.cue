// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/iam/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#UserLoginProfileInitParameters: {
	// The length of the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument. Default value is 20.
	passwordLength?: null | float64 @go(PasswordLength,*float64)

	// Whether the user should be forced to reset the generated password on resource creation. Only applies on resource creation.
	passwordResetRequired?: null | bool @go(PasswordResetRequired,*bool)

	// Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Only applies on resource creation. Drift detection is not possible with this argument.
	pgpKey?: null | string @go(PgpKey,*string)
}

#UserLoginProfileObservation: {
	// The encrypted password, base64 encoded.
	encryptedPassword?: null | string @go(EncryptedPassword,*string)
	id?:                null | string @go(ID,*string)

	// The fingerprint of the PGP key used to encrypt the password.
	keyFingerprint?: null | string @go(KeyFingerprint,*string)

	// The plain text password, only available when pgp_key is not provided.
	password?: null | string @go(Password,*string)

	// The length of the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument. Default value is 20.
	passwordLength?: null | float64 @go(PasswordLength,*float64)

	// Whether the user should be forced to reset the generated password on resource creation. Only applies on resource creation.
	passwordResetRequired?: null | bool @go(PasswordResetRequired,*bool)

	// Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Only applies on resource creation. Drift detection is not possible with this argument.
	pgpKey?: null | string @go(PgpKey,*string)

	// The IAM user's name.
	user?: null | string @go(User,*string)
}

#UserLoginProfileParameters: {
	// The length of the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument. Default value is 20.
	// +kubebuilder:validation:Optional
	passwordLength?: null | float64 @go(PasswordLength,*float64)

	// Whether the user should be forced to reset the generated password on resource creation. Only applies on resource creation.
	// +kubebuilder:validation:Optional
	passwordResetRequired?: null | bool @go(PasswordResetRequired,*bool)

	// Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Only applies on resource creation. Drift detection is not possible with this argument.
	// +kubebuilder:validation:Optional
	pgpKey?: null | string @go(PgpKey,*string)

	// The IAM user's name.
	// +crossplane:generate:reference:type=User
	// +kubebuilder:validation:Optional
	user?: null | string @go(User,*string)

	// Reference to a User to populate user.
	// +kubebuilder:validation:Optional
	userRef?: null | v1.#Reference @go(UserRef,*v1.Reference)

	// Selector for a User to populate user.
	// +kubebuilder:validation:Optional
	userSelector?: null | v1.#Selector @go(UserSelector,*v1.Selector)
}

// UserLoginProfileSpec defines the desired state of UserLoginProfile
#UserLoginProfileSpec: {
	v1.#ResourceSpec
	forProvider: #UserLoginProfileParameters @go(ForProvider)

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
	initProvider?: #UserLoginProfileInitParameters @go(InitProvider)
}

// UserLoginProfileStatus defines the observed state of UserLoginProfile.
#UserLoginProfileStatus: {
	v1.#ResourceStatus
	atProvider?: #UserLoginProfileObservation @go(AtProvider)
}

// UserLoginProfile is the Schema for the UserLoginProfiles API. Manages an IAM User Login Profile
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#UserLoginProfile: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta      @go(ObjectMeta)
	spec:      #UserLoginProfileSpec   @go(Spec)
	status?:   #UserLoginProfileStatus @go(Status)
}

// UserLoginProfileList contains a list of UserLoginProfiles
#UserLoginProfileList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#UserLoginProfile] @go(Items,[]UserLoginProfile)
}
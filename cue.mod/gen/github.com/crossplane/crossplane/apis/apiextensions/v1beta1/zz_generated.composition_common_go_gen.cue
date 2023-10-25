// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/crossplane/crossplane/apis/apiextensions/v1beta1

package v1beta1

import (
	"k8s.io/apimachinery/pkg/runtime"
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	corev1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/api/resource"
)

// TypeReference is used to refer to a type for declaring compatibility.
#TypeReference: {
	// APIVersion of the type.
	apiVersion: string @go(APIVersion)

	// Kind of the type.
	kind: string @go(Kind)
}

// A PatchSet is a set of patches that can be reused from all resources within
// a Composition.
#PatchSet: {
	// Name of this PatchSet.
	name: string @go(Name)

	// Patches will be applied as an overlay to the base resource.
	patches: [...#Patch] @go(Patches,[]Patch)
}

// ComposedTemplate is used to provide information about how the composed resource
// should be processed.
#ComposedTemplate: {
	// A Name uniquely identifies this entry within its Composition's resources
	// array. Names are optional but *strongly* recommended. When all entries in
	// the resources array are named entries may added, deleted, and reordered
	// as long as their names do not change. When entries are not named the
	// length and order of the resources array should be treated as immutable.
	// Either all or no entries must be named.
	// +optional
	name?: null | string @go(Name,*string)

	// Base is the target resource that the patches will be applied on.
	// +kubebuilder:pruning:PreserveUnknownFields
	// +kubebuilder:validation:EmbeddedResource
	base: runtime.#RawExtension @go(Base)

	// Patches will be applied as overlay to the base resource.
	// +optional
	patches?: [...#Patch] @go(Patches,[]Patch)

	// ConnectionDetails lists the propagation secret keys from this target
	// resource to the composition instance connection secret.
	// +optional
	connectionDetails?: [...#ConnectionDetail] @go(ConnectionDetails,[]ConnectionDetail)

	// ReadinessChecks allows users to define custom readiness checks. All checks
	// have to return true in order for resource to be considered ready. The
	// default readiness check is to have the "Ready" condition to be "True".
	// +optional
	// +kubebuilder:default={{type:"MatchCondition",matchCondition:{type:"Ready",status:"True"}}}
	readinessChecks?: [...#ReadinessCheck] @go(ReadinessChecks,[]ReadinessCheck)
}

// ReadinessCheckType is used for readiness check types.
#ReadinessCheckType: string // #enumReadinessCheckType

#enumReadinessCheckType:
	#ReadinessCheckTypeNonEmpty |
	#ReadinessCheckTypeMatchString |
	#ReadinessCheckTypeMatchInteger |
	#ReadinessCheckTypeMatchCondition |
	#ReadinessCheckTypeNone

#ReadinessCheckTypeNonEmpty:       #ReadinessCheckType & "NonEmpty"
#ReadinessCheckTypeMatchString:    #ReadinessCheckType & "MatchString"
#ReadinessCheckTypeMatchInteger:   #ReadinessCheckType & "MatchInteger"
#ReadinessCheckTypeMatchCondition: #ReadinessCheckType & "MatchCondition"
#ReadinessCheckTypeNone:           #ReadinessCheckType & "None"

// ReadinessCheck is used to indicate how to tell whether a resource is ready
// for consumption
#ReadinessCheck: {
	// Type indicates the type of probe you'd like to use.
	// +kubebuilder:validation:Enum="MatchString";"MatchInteger";"NonEmpty";"MatchCondition";"None"
	type: #ReadinessCheckType @go(Type)

	// FieldPath shows the path of the field whose value will be used.
	// +optional
	fieldPath?: string @go(FieldPath)

	// MatchString is the value you'd like to match if you're using "MatchString" type.
	// +optional
	matchString?: string @go(MatchString)

	// MatchInt is the value you'd like to match if you're using "MatchInt" type.
	// +optional
	matchInteger?: int64 @go(MatchInteger)

	// MatchCondition specifies the condition you'd like to match if you're using "MatchCondition" type.
	// +optional
	matchCondition?: null | #MatchConditionReadinessCheck @go(MatchCondition,*MatchConditionReadinessCheck)
}

// MatchConditionReadinessCheck is used to indicate how to tell whether a resource is ready
// for consumption
#MatchConditionReadinessCheck: {
	// Type indicates the type of condition you'd like to use.
	// +kubebuilder:default="Ready"
	type: xpv1.#ConditionType @go(Type)

	// Status is the status of the condition you'd like to match.
	// +kubebuilder:default="True"
	status: corev1.#ConditionStatus @go(Status)
}

// A ConnectionDetailType is a type of connection detail.
#ConnectionDetailType: string // #enumConnectionDetailType

#enumConnectionDetailType:
	#ConnectionDetailTypeUnknown |
	#ConnectionDetailTypeFromConnectionSecretKey |
	#ConnectionDetailTypeFromFieldPath |
	#ConnectionDetailTypeFromValue

#ConnectionDetailTypeUnknown:                 #ConnectionDetailType & "Unknown"
#ConnectionDetailTypeFromConnectionSecretKey: #ConnectionDetailType & "FromConnectionSecretKey"
#ConnectionDetailTypeFromFieldPath:           #ConnectionDetailType & "FromFieldPath"
#ConnectionDetailTypeFromValue:               #ConnectionDetailType & "FromValue"

// ConnectionDetail includes the information about the propagation of the connection
// information from one secret to another.
#ConnectionDetail: {
	// Name of the connection secret key that will be propagated to the
	// connection secret of the composition instance. Leave empty if you'd like
	// to use the same key name.
	// +optional
	name?: null | string @go(Name,*string)

	// Type sets the connection detail fetching behaviour to be used. Each
	// connection detail type may require its own fields to be set on the
	// ConnectionDetail object. If the type is omitted Crossplane will attempt
	// to infer it based on which other fields were specified. If multiple
	// fields are specified the order of precedence is:
	// 1. FromValue
	// 2. FromConnectionSecretKey
	// 3. FromFieldPath
	// +optional
	// +kubebuilder:validation:Enum=FromConnectionSecretKey;FromFieldPath;FromValue
	type?: null | #ConnectionDetailType @go(Type,*ConnectionDetailType)

	// FromConnectionSecretKey is the key that will be used to fetch the value
	// from the composed resource's connection secret.
	// +optional
	fromConnectionSecretKey?: null | string @go(FromConnectionSecretKey,*string)

	// FromFieldPath is the path of the field on the composed resource whose
	// value to be used as input. Name must be specified if the type is
	// FromFieldPath.
	// +optional
	fromFieldPath?: null | string @go(FromFieldPath,*string)

	// Value that will be propagated to the connection secret of the composite
	// resource. May be set to inject a fixed, non-sensitive connection secret
	// value, for example a well-known port.
	// +optional
	value?: null | string @go(Value,*string)
}

// A Function represents a Composition Function.
#Function: {
	// Name of this function. Must be unique within its Composition.
	name: string @go(Name)

	// Type of this function.
	// +kubebuilder:validation:Enum=Container
	type: #FunctionType @go(Type)

	// Config is an optional, arbitrary Kubernetes resource (i.e. a resource
	// with an apiVersion and kind) that will be passed to the Composition
	// Function as the 'config' block of its FunctionIO.
	// +optional
	// +kubebuilder:pruning:PreserveUnknownFields
	// +kubebuilder:validation:EmbeddedResource
	config?: null | runtime.#RawExtension @go(Config,*runtime.RawExtension)

	// Container configuration of this function.
	// +optional
	container?: null | #ContainerFunction @go(Container,*ContainerFunction)
}

// A FunctionType is a type of Composition Function.
#FunctionType: string // #enumFunctionType

#enumFunctionType:
	#FunctionTypeContainer

// FunctionTypeContainer represents a Composition Function that is packaged
// as an OCI image and run in a container.
#FunctionTypeContainer: #FunctionType & "Container"

// A ContainerFunction represents an Composition Function that is packaged as an
// OCI image and run in a container.
#ContainerFunction: {
	// Image specifies the OCI image in which the function is packaged. The
	// image should include an entrypoint that reads a FunctionIO from stdin and
	// emits it, optionally mutated, to stdout.
	image: string @go(Image)

	// ImagePullPolicy defines the pull policy for the function image.
	// +optional
	// +kubebuilder:default=IfNotPresent
	// +kubebuilder:validation:Enum="IfNotPresent";"Always";"Never"
	imagePullPolicy?: null | corev1.#PullPolicy @go(ImagePullPolicy,*corev1.PullPolicy)

	// ImagePullSecrets are used to pull images from private OCI registries.
	// +optional
	imagePullSecrets?: [...corev1.#LocalObjectReference] @go(ImagePullSecrets,[]corev1.LocalObjectReference)

	// Timeout after which the Composition Function will be killed.
	// +optional
	// +kubebuilder:default="20s"
	timeout?: null | metav1.#Duration @go(Timeout,*metav1.Duration)

	// Network configuration for the Composition Function.
	// +optional
	network?: null | #ContainerFunctionNetwork @go(Network,*ContainerFunctionNetwork)

	// Resources that may be used by the Composition Function.
	// +optional
	resources?: null | #ContainerFunctionResources @go(Resources,*ContainerFunctionResources)

	// Runner configuration for the Composition Function.
	// +optional
	runner?: null | #ContainerFunctionRunner @go(Runner,*ContainerFunctionRunner)
}

// A ContainerFunctionNetworkPolicy specifies the network policy under which
// a containerized Composition Function will run.
#ContainerFunctionNetworkPolicy: string // #enumContainerFunctionNetworkPolicy

#enumContainerFunctionNetworkPolicy:
	#ContainerFunctionNetworkPolicyIsolated |
	#ContainerFunctionNetworkPolicyRunner

// ContainerFunctionNetworkPolicyIsolated specifies that the Composition
// Function will not have network access; i.e. invoked inside an isolated
// network namespace.
#ContainerFunctionNetworkPolicyIsolated: #ContainerFunctionNetworkPolicy & "Isolated"

// ContainerFunctionNetworkPolicyRunner specifies that the Composition
// Function will have the same network access as its runner, i.e. share its
// runner's network namespace.
#ContainerFunctionNetworkPolicyRunner: #ContainerFunctionNetworkPolicy & "Runner"

// ContainerFunctionNetwork represents configuration for a Composition Function.
#ContainerFunctionNetwork: {
	// Policy specifies the network policy under which the Composition Function
	// will run. Defaults to 'Isolated' - i.e. no network access. Specify
	// 'Runner' to allow the function the same network access as
	// its runner.
	// +optional
	// +kubebuilder:validation:Enum="Isolated";"Runner"
	// +kubebuilder:default=Isolated
	policy?: null | #ContainerFunctionNetworkPolicy @go(Policy,*ContainerFunctionNetworkPolicy)
}

// ContainerFunctionResources represents compute resources that may be used by a
// Composition Function.
#ContainerFunctionResources: {
	// Limits specify the maximum compute resources that may be used by the
	// Composition Function.
	// +optional
	limits?: null | #ContainerFunctionResourceLimits @go(Limits,*ContainerFunctionResourceLimits)
}

// ContainerFunctionResourceLimits specify the maximum compute resources
// that may be used by a Composition Function.
#ContainerFunctionResourceLimits: {
	// CPU, in cores. (500m = .5 cores)
	// +kubebuilder:default="100m"
	// +optional
	cpu?: null | resource.#Quantity @go(CPU,*resource.Quantity)

	// Memory, in bytes. (500Gi = 500GiB = 500 * 1024 * 1024 * 1024)
	// +kubebuilder:default="128Mi"
	// +optional
	memory?: null | resource.#Quantity @go(Memory,*resource.Quantity)
}

// ContainerFunctionRunner represents runner configuration for a Composition
// Function.
#ContainerFunctionRunner: {
	// Endpoint specifies how and where Crossplane should reach the runner it
	// uses to invoke containerized Composition Functions.
	// +optional
	// +kubebuilder:default="unix-abstract:crossplane/fn/default.sock"
	endpoint?: null | string @go(Endpoint,*string)
}

// A StoreConfigReference references a secret store config that may be used to
// write connection details.
#StoreConfigReference: {
	// Name of the referenced StoreConfig.
	name: string @go(Name)
}
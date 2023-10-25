// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/lightsail/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#StaticIPAttachmentInitParameters: {
}

#StaticIPAttachmentObservation: {
	id?: null | string @go(ID,*string)

	// The allocated static IP address
	ipAddress?: null | string @go(IPAddress,*string)

	// The name of the Lightsail instance to attach the IP to
	instanceName?: null | string @go(InstanceName,*string)

	// The name of the allocated static IP
	staticIpName?: null | string @go(StaticIPName,*string)
}

#StaticIPAttachmentParameters: {
	// The name of the Lightsail instance to attach the IP to
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/lightsail/v1beta1.Instance
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	instanceName?: null | string @go(InstanceName,*string)

	// Reference to a Instance in lightsail to populate instanceName.
	// +kubebuilder:validation:Optional
	instanceNameRef?: null | v1.#Reference @go(InstanceNameRef,*v1.Reference)

	// Selector for a Instance in lightsail to populate instanceName.
	// +kubebuilder:validation:Optional
	instanceNameSelector?: null | v1.#Selector @go(InstanceNameSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The name of the allocated static IP
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/lightsail/v1beta1.StaticIP
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	staticIpName?: null | string @go(StaticIPName,*string)

	// Reference to a StaticIP in lightsail to populate staticIpName.
	// +kubebuilder:validation:Optional
	staticIpNameRef?: null | v1.#Reference @go(StaticIPNameRef,*v1.Reference)

	// Selector for a StaticIP in lightsail to populate staticIpName.
	// +kubebuilder:validation:Optional
	staticIpNameSelector?: null | v1.#Selector @go(StaticIPNameSelector,*v1.Selector)
}

// StaticIPAttachmentSpec defines the desired state of StaticIPAttachment
#StaticIPAttachmentSpec: {
	v1.#ResourceSpec
	forProvider: #StaticIPAttachmentParameters @go(ForProvider)

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
	initProvider?: #StaticIPAttachmentInitParameters @go(InitProvider)
}

// StaticIPAttachmentStatus defines the observed state of StaticIPAttachment.
#StaticIPAttachmentStatus: {
	v1.#ResourceStatus
	atProvider?: #StaticIPAttachmentObservation @go(AtProvider)
}

// StaticIPAttachment is the Schema for the StaticIPAttachments API. Provides an Lightsail Static IP Attachment
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#StaticIPAttachment: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta        @go(ObjectMeta)
	spec:      #StaticIPAttachmentSpec   @go(Spec)
	status?:   #StaticIPAttachmentStatus @go(Status)
}

// StaticIPAttachmentList contains a list of StaticIPAttachments
#StaticIPAttachmentList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#StaticIPAttachment] @go(Items,[]StaticIPAttachment)
}
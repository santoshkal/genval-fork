// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#VPCEndpointSubnetAssociationInitParameters: {
}

#VPCEndpointSubnetAssociationObservation: {
	// The ID of the association.
	id?: null | string @go(ID,*string)

	// The ID of the subnet to be associated with the VPC endpoint.
	subnetId?: null | string @go(SubnetID,*string)

	// The ID of the VPC endpoint with which the subnet will be associated.
	vpcEndpointId?: null | string @go(VPCEndpointID,*string)
}

#VPCEndpointSubnetAssociationParameters: {
	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The ID of the subnet to be associated with the VPC endpoint.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.Subnet
	// +kubebuilder:validation:Optional
	subnetId?: null | string @go(SubnetID,*string)

	// Reference to a Subnet in ec2 to populate subnetId.
	// +kubebuilder:validation:Optional
	subnetIdRef?: null | v1.#Reference @go(SubnetIDRef,*v1.Reference)

	// Selector for a Subnet in ec2 to populate subnetId.
	// +kubebuilder:validation:Optional
	subnetIdSelector?: null | v1.#Selector @go(SubnetIDSelector,*v1.Selector)

	// The ID of the VPC endpoint with which the subnet will be associated.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.VPCEndpoint
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	vpcEndpointId?: null | string @go(VPCEndpointID,*string)

	// Reference to a VPCEndpoint in ec2 to populate vpcEndpointId.
	// +kubebuilder:validation:Optional
	vpcEndpointIdRef?: null | v1.#Reference @go(VPCEndpointIDRef,*v1.Reference)

	// Selector for a VPCEndpoint in ec2 to populate vpcEndpointId.
	// +kubebuilder:validation:Optional
	vpcEndpointIdSelector?: null | v1.#Selector @go(VPCEndpointIDSelector,*v1.Selector)
}

// VPCEndpointSubnetAssociationSpec defines the desired state of VPCEndpointSubnetAssociation
#VPCEndpointSubnetAssociationSpec: {
	v1.#ResourceSpec
	forProvider: #VPCEndpointSubnetAssociationParameters @go(ForProvider)

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
	initProvider?: #VPCEndpointSubnetAssociationInitParameters @go(InitProvider)
}

// VPCEndpointSubnetAssociationStatus defines the observed state of VPCEndpointSubnetAssociation.
#VPCEndpointSubnetAssociationStatus: {
	v1.#ResourceStatus
	atProvider?: #VPCEndpointSubnetAssociationObservation @go(AtProvider)
}

// VPCEndpointSubnetAssociation is the Schema for the VPCEndpointSubnetAssociations API. Provides a resource to create an association between a VPC endpoint and a subnet.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#VPCEndpointSubnetAssociation: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta                  @go(ObjectMeta)
	spec:      #VPCEndpointSubnetAssociationSpec   @go(Spec)
	status?:   #VPCEndpointSubnetAssociationStatus @go(Status)
}

// VPCEndpointSubnetAssociationList contains a list of VPCEndpointSubnetAssociations
#VPCEndpointSubnetAssociationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#VPCEndpointSubnetAssociation] @go(Items,[]VPCEndpointSubnetAssociation)
}
// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#TransitGatewayVPCAttachmentInitParameters: {
	// Whether Appliance Mode support is enabled. If enabled, a traffic flow between a source and destination uses the same Availability Zone for the VPC attachment for the lifetime of that flow. Valid values: disable, enable. Default value: disable.
	applianceModeSupport?: null | string @go(ApplianceModeSupport,*string)

	// Whether DNS support is enabled. Valid values: disable, enable. Default value: enable.
	dnsSupport?: null | string @go(DNSSupport,*string)

	// Whether IPv6 support is enabled. Valid values: disable, enable. Default value: disable.
	ipv6Support?: null | string @go(IPv6Support,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Boolean whether the VPC Attachment should be associated with the EC2 Transit Gateway association default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true.
	transitGatewayDefaultRouteTableAssociation?: null | bool @go(TransitGatewayDefaultRouteTableAssociation,*bool)

	// Boolean whether the VPC Attachment should propagate routes with the EC2 Transit Gateway propagation default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true.
	transitGatewayDefaultRouteTablePropagation?: null | bool @go(TransitGatewayDefaultRouteTablePropagation,*bool)
}

#TransitGatewayVPCAttachmentObservation: {
	// Whether Appliance Mode support is enabled. If enabled, a traffic flow between a source and destination uses the same Availability Zone for the VPC attachment for the lifetime of that flow. Valid values: disable, enable. Default value: disable.
	applianceModeSupport?: null | string @go(ApplianceModeSupport,*string)

	// Whether DNS support is enabled. Valid values: disable, enable. Default value: enable.
	dnsSupport?: null | string @go(DNSSupport,*string)

	// EC2 Transit Gateway Attachment identifier
	id?: null | string @go(ID,*string)

	// Whether IPv6 support is enabled. Valid values: disable, enable. Default value: disable.
	ipv6Support?: null | string @go(IPv6Support,*string)

	// Identifiers of EC2 Subnets.
	subnetIds?: [...null | string] @go(SubnetIds,[]*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// Boolean whether the VPC Attachment should be associated with the EC2 Transit Gateway association default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true.
	transitGatewayDefaultRouteTableAssociation?: null | bool @go(TransitGatewayDefaultRouteTableAssociation,*bool)

	// Boolean whether the VPC Attachment should propagate routes with the EC2 Transit Gateway propagation default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true.
	transitGatewayDefaultRouteTablePropagation?: null | bool @go(TransitGatewayDefaultRouteTablePropagation,*bool)

	// Identifier of EC2 Transit Gateway.
	transitGatewayId?: null | string @go(TransitGatewayID,*string)

	// Identifier of EC2 VPC.
	vpcId?: null | string @go(VPCID,*string)

	// Identifier of the AWS account that owns the EC2 VPC.
	vpcOwnerId?: null | string @go(VPCOwnerID,*string)
}

#TransitGatewayVPCAttachmentParameters: {
	// Whether Appliance Mode support is enabled. If enabled, a traffic flow between a source and destination uses the same Availability Zone for the VPC attachment for the lifetime of that flow. Valid values: disable, enable. Default value: disable.
	// +kubebuilder:validation:Optional
	applianceModeSupport?: null | string @go(ApplianceModeSupport,*string)

	// Whether DNS support is enabled. Valid values: disable, enable. Default value: enable.
	// +kubebuilder:validation:Optional
	dnsSupport?: null | string @go(DNSSupport,*string)

	// Whether IPv6 support is enabled. Valid values: disable, enable. Default value: disable.
	// +kubebuilder:validation:Optional
	ipv6Support?: null | string @go(IPv6Support,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// References to Subnet in ec2 to populate subnetIds.
	// +kubebuilder:validation:Optional
	subnetIdRefs?: [...v1.#Reference] @go(SubnetIDRefs,[]v1.Reference)

	// Selector for a list of Subnet in ec2 to populate subnetIds.
	// +kubebuilder:validation:Optional
	subnetIdSelector?: null | v1.#Selector @go(SubnetIDSelector,*v1.Selector)

	// Identifiers of EC2 Subnets.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.Subnet
	// +crossplane:generate:reference:refFieldName=SubnetIDRefs
	// +crossplane:generate:reference:selectorFieldName=SubnetIDSelector
	// +kubebuilder:validation:Optional
	subnetIds?: [...null | string] @go(SubnetIds,[]*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Boolean whether the VPC Attachment should be associated with the EC2 Transit Gateway association default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true.
	// +kubebuilder:validation:Optional
	transitGatewayDefaultRouteTableAssociation?: null | bool @go(TransitGatewayDefaultRouteTableAssociation,*bool)

	// Boolean whether the VPC Attachment should propagate routes with the EC2 Transit Gateway propagation default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true.
	// +kubebuilder:validation:Optional
	transitGatewayDefaultRouteTablePropagation?: null | bool @go(TransitGatewayDefaultRouteTablePropagation,*bool)

	// Identifier of EC2 Transit Gateway.
	// +crossplane:generate:reference:type=TransitGateway
	// +kubebuilder:validation:Optional
	transitGatewayId?: null | string @go(TransitGatewayID,*string)

	// Reference to a TransitGateway to populate transitGatewayId.
	// +kubebuilder:validation:Optional
	transitGatewayIdRef?: null | v1.#Reference @go(TransitGatewayIDRef,*v1.Reference)

	// Selector for a TransitGateway to populate transitGatewayId.
	// +kubebuilder:validation:Optional
	transitGatewayIdSelector?: null | v1.#Selector @go(TransitGatewayIDSelector,*v1.Selector)

	// Identifier of EC2 VPC.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.VPC
	// +kubebuilder:validation:Optional
	vpcId?: null | string @go(VPCID,*string)

	// Reference to a VPC in ec2 to populate vpcId.
	// +kubebuilder:validation:Optional
	vpcIdRef?: null | v1.#Reference @go(VPCIDRef,*v1.Reference)

	// Selector for a VPC in ec2 to populate vpcId.
	// +kubebuilder:validation:Optional
	vpcIdSelector?: null | v1.#Selector @go(VPCIDSelector,*v1.Selector)
}

// TransitGatewayVPCAttachmentSpec defines the desired state of TransitGatewayVPCAttachment
#TransitGatewayVPCAttachmentSpec: {
	v1.#ResourceSpec
	forProvider: #TransitGatewayVPCAttachmentParameters @go(ForProvider)

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
	initProvider?: #TransitGatewayVPCAttachmentInitParameters @go(InitProvider)
}

// TransitGatewayVPCAttachmentStatus defines the observed state of TransitGatewayVPCAttachment.
#TransitGatewayVPCAttachmentStatus: {
	v1.#ResourceStatus
	atProvider?: #TransitGatewayVPCAttachmentObservation @go(AtProvider)
}

// TransitGatewayVPCAttachment is the Schema for the TransitGatewayVPCAttachments API. Manages an EC2 Transit Gateway VPC Attachment
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#TransitGatewayVPCAttachment: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta                 @go(ObjectMeta)
	spec:      #TransitGatewayVPCAttachmentSpec   @go(Spec)
	status?:   #TransitGatewayVPCAttachmentStatus @go(Status)
}

// TransitGatewayVPCAttachmentList contains a list of TransitGatewayVPCAttachments
#TransitGatewayVPCAttachmentList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#TransitGatewayVPCAttachment] @go(Items,[]TransitGatewayVPCAttachment)
}
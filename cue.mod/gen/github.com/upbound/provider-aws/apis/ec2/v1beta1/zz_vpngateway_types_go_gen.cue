// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#VPNGatewayInitParameters_2: {
	// The Autonomous System Number (ASN) for the Amazon side of the gateway. If you don't specify an ASN, the virtual private gateway is created with the default ASN.
	amazonSideAsn?: null | string @go(AmazonSideAsn,*string)

	// The Availability Zone for the virtual private gateway.
	availabilityZone?: null | string @go(AvailabilityZone,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#VPNGatewayObservation_2: {
	// The Autonomous System Number (ASN) for the Amazon side of the gateway. If you don't specify an ASN, the virtual private gateway is created with the default ASN.
	amazonSideAsn?: null | string @go(AmazonSideAsn,*string)

	// Amazon Resource Name (ARN) of the VPN Gateway.
	arn?: null | string @go(Arn,*string)

	// The Availability Zone for the virtual private gateway.
	availabilityZone?: null | string @go(AvailabilityZone,*string)

	// The ID of the VPN Gateway.
	id?: null | string @go(ID,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// The VPC ID to create in.
	vpcId?: null | string @go(VPCID,*string)
}

#VPNGatewayParameters_2: {
	// The Autonomous System Number (ASN) for the Amazon side of the gateway. If you don't specify an ASN, the virtual private gateway is created with the default ASN.
	// +kubebuilder:validation:Optional
	amazonSideAsn?: null | string @go(AmazonSideAsn,*string)

	// The Availability Zone for the virtual private gateway.
	// +kubebuilder:validation:Optional
	availabilityZone?: null | string @go(AvailabilityZone,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The VPC ID to create in.
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

// VPNGatewaySpec defines the desired state of VPNGateway
#VPNGatewaySpec: {
	v1.#ResourceSpec
	forProvider: #VPNGatewayParameters_2 @go(ForProvider)

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
	initProvider?: #VPNGatewayInitParameters_2 @go(InitProvider)
}

// VPNGatewayStatus defines the observed state of VPNGateway.
#VPNGatewayStatus: {
	v1.#ResourceStatus
	atProvider?: #VPNGatewayObservation_2 @go(AtProvider)
}

// VPNGateway is the Schema for the VPNGateways API. Provides a resource to create a VPC VPN Gateway.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#VPNGateway: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #VPNGatewaySpec    @go(Spec)
	status?:   #VPNGatewayStatus  @go(Status)
}

// VPNGatewayList contains a list of VPNGateways
#VPNGatewayList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#VPNGateway] @go(Items,[]VPNGateway)
}
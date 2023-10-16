// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#TransitGatewayPeeringAttachmentAccepterInitParameters: {
	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#TransitGatewayPeeringAttachmentAccepterObservation: {
	// EC2 Transit Gateway Attachment identifier
	id?: null | string @go(ID,*string)

	// Identifier of the AWS account that owns the EC2 TGW peering.
	peerAccountId?: null | string @go(PeerAccountID,*string)
	peerRegion?:    null | string @go(PeerRegion,*string)

	// Identifier of EC2 Transit Gateway to peer with.
	peerTransitGatewayId?: null | string @go(PeerTransitGatewayID,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// The ID of the EC2 Transit Gateway Peering Attachment to manage.
	transitGatewayAttachmentId?: null | string @go(TransitGatewayAttachmentID,*string)

	// Identifier of EC2 Transit Gateway.
	transitGatewayId?: null | string @go(TransitGatewayID,*string)
}

#TransitGatewayPeeringAttachmentAccepterParameters: {
	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The ID of the EC2 Transit Gateway Peering Attachment to manage.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.TransitGatewayPeeringAttachment
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	transitGatewayAttachmentId?: null | string @go(TransitGatewayAttachmentID,*string)

	// Reference to a TransitGatewayPeeringAttachment in ec2 to populate transitGatewayAttachmentId.
	// +kubebuilder:validation:Optional
	transitGatewayAttachmentIdRef?: null | v1.#Reference @go(TransitGatewayAttachmentIDRef,*v1.Reference)

	// Selector for a TransitGatewayPeeringAttachment in ec2 to populate transitGatewayAttachmentId.
	// +kubebuilder:validation:Optional
	transitGatewayAttachmentIdSelector?: null | v1.#Selector @go(TransitGatewayAttachmentIDSelector,*v1.Selector)
}

// TransitGatewayPeeringAttachmentAccepterSpec defines the desired state of TransitGatewayPeeringAttachmentAccepter
#TransitGatewayPeeringAttachmentAccepterSpec: {
	v1.#ResourceSpec
	forProvider: #TransitGatewayPeeringAttachmentAccepterParameters @go(ForProvider)

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
	initProvider?: #TransitGatewayPeeringAttachmentAccepterInitParameters @go(InitProvider)
}

// TransitGatewayPeeringAttachmentAccepterStatus defines the observed state of TransitGatewayPeeringAttachmentAccepter.
#TransitGatewayPeeringAttachmentAccepterStatus: {
	v1.#ResourceStatus
	atProvider?: #TransitGatewayPeeringAttachmentAccepterObservation @go(AtProvider)
}

// TransitGatewayPeeringAttachmentAccepter is the Schema for the TransitGatewayPeeringAttachmentAccepters API. Manages the accepter's side of an EC2 Transit Gateway peering Attachment
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#TransitGatewayPeeringAttachmentAccepter: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta                             @go(ObjectMeta)
	spec:      #TransitGatewayPeeringAttachmentAccepterSpec   @go(Spec)
	status?:   #TransitGatewayPeeringAttachmentAccepterStatus @go(Status)
}

// TransitGatewayPeeringAttachmentAccepterList contains a list of TransitGatewayPeeringAttachmentAccepters
#TransitGatewayPeeringAttachmentAccepterList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#TransitGatewayPeeringAttachmentAccepter] @go(Items,[]TransitGatewayPeeringAttachmentAccepter)
}
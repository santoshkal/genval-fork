// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/kafka/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ScramSecretAssociationInitParameters: {
}

#ScramSecretAssociationObservation: {
	// Amazon Resource Name (ARN) of the MSK cluster.
	clusterArn?: null | string @go(ClusterArn,*string)

	// Amazon Resource Name (ARN) of the MSK cluster.
	id?: null | string @go(ID,*string)

	// List of all AWS Secrets Manager secret ARNs to associate with the cluster. Secrets not referenced, selected or listed here will be disassociated from the cluster.
	secretArnList?: [...null | string] @go(SecretArnList,[]*string)
}

#ScramSecretAssociationParameters: {
	// Amazon Resource Name (ARN) of the MSK cluster.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/kafka/v1beta1.Cluster
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	clusterArn?: null | string @go(ClusterArn,*string)

	// Reference to a Cluster in kafka to populate clusterArn.
	// +kubebuilder:validation:Optional
	clusterArnRef?: null | v1.#Reference @go(ClusterArnRef,*v1.Reference)

	// Selector for a Cluster in kafka to populate clusterArn.
	// +kubebuilder:validation:Optional
	clusterArnSelector?: null | v1.#Selector @go(ClusterArnSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// List of all AWS Secrets Manager secret ARNs to associate with the cluster. Secrets not referenced, selected or listed here will be disassociated from the cluster.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/secretsmanager/v1beta1.Secret
	// +crossplane:generate:reference:refFieldName=SecretArnRefs
	// +crossplane:generate:reference:selectorFieldName=SecretArnSelector
	// +kubebuilder:validation:Optional
	secretArnList?: [...null | string] @go(SecretArnList,[]*string)

	// References to Secret in secretsmanager to populate secretArnList.
	// +kubebuilder:validation:Optional
	secretArnRefs?: [...v1.#Reference] @go(SecretArnRefs,[]v1.Reference)

	// Selector for a list of Secret in secretsmanager to populate secretArnList.
	// +kubebuilder:validation:Optional
	secretArnSelector?: null | v1.#Selector @go(SecretArnSelector,*v1.Selector)
}

// ScramSecretAssociationSpec defines the desired state of ScramSecretAssociation
#ScramSecretAssociationSpec: {
	v1.#ResourceSpec
	forProvider: #ScramSecretAssociationParameters @go(ForProvider)

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
	initProvider?: #ScramSecretAssociationInitParameters @go(InitProvider)
}

// ScramSecretAssociationStatus defines the observed state of ScramSecretAssociation.
#ScramSecretAssociationStatus: {
	v1.#ResourceStatus
	atProvider?: #ScramSecretAssociationObservation @go(AtProvider)
}

// ScramSecretAssociation is the Schema for the ScramSecretAssociations API. Associates SCRAM secrets with a Managed Streaming for Kafka (MSK) cluster.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ScramSecretAssociation: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta            @go(ObjectMeta)
	spec:      #ScramSecretAssociationSpec   @go(Spec)
	status?:   #ScramSecretAssociationStatus @go(Status)
}

// ScramSecretAssociationList contains a list of ScramSecretAssociations
#ScramSecretAssociationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ScramSecretAssociation] @go(Items,[]ScramSecretAssociation)
}
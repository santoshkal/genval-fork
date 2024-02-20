// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/dynamodb/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#GlobalTableInitParameters: {
	// Underlying DynamoDB Table. At least 1 replica must be defined. See below.
	replica?: [...#ReplicaInitParameters] @go(Replica,[]ReplicaInitParameters)
}

#GlobalTableObservation: {
	// The ARN of the DynamoDB Global Table
	arn?: null | string @go(Arn,*string)

	// The name of the DynamoDB Global Table
	id?: null | string @go(ID,*string)

	// Underlying DynamoDB Table. At least 1 replica must be defined. See below.
	replica?: [...#ReplicaObservation] @go(Replica,[]ReplicaObservation)
}

#GlobalTableParameters: {
	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Underlying DynamoDB Table. At least 1 replica must be defined. See below.
	// +kubebuilder:validation:Optional
	replica?: [...#ReplicaParameters] @go(Replica,[]ReplicaParameters)
}

#ReplicaInitParameters: {
	// AWS region name of replica DynamoDB TableE.g., us-east-1
	regionName?: null | string @go(RegionName,*string)
}

#ReplicaObservation: {
	// AWS region name of replica DynamoDB TableE.g., us-east-1
	regionName?: null | string @go(RegionName,*string)
}

#ReplicaParameters: {
	// AWS region name of replica DynamoDB TableE.g., us-east-1
	// +kubebuilder:validation:Optional
	regionName?: null | string @go(RegionName,*string)
}

// GlobalTableSpec defines the desired state of GlobalTable
#GlobalTableSpec: {
	v1.#ResourceSpec
	forProvider: #GlobalTableParameters @go(ForProvider)

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
	initProvider?: #GlobalTableInitParameters @go(InitProvider)
}

// GlobalTableStatus defines the observed state of GlobalTable.
#GlobalTableStatus: {
	v1.#ResourceStatus
	atProvider?: #GlobalTableObservation @go(AtProvider)
}

// GlobalTable is the Schema for the GlobalTables API. Manages DynamoDB Global Tables V1 (version 2017.11.29)
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#GlobalTable: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.replica) || (has(self.initProvider) && has(self.initProvider.replica))",message="spec.forProvider.replica is a required parameter"
	spec:    #GlobalTableSpec   @go(Spec)
	status?: #GlobalTableStatus @go(Status)
}

// GlobalTableList contains a list of GlobalTables
#GlobalTableList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#GlobalTable] @go(Items,[]GlobalTable)
}
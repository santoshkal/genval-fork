// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/evidently/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#CloudwatchLogsInitParameters: {
	// The name of the log group where the project stores evaluation events.
	logGroup?: null | string @go(LogGroup,*string)
}

#CloudwatchLogsObservation: {
	// The name of the log group where the project stores evaluation events.
	logGroup?: null | string @go(LogGroup,*string)
}

#CloudwatchLogsParameters: {
	// The name of the log group where the project stores evaluation events.
	// +kubebuilder:validation:Optional
	logGroup?: null | string @go(LogGroup,*string)
}

#DataDeliveryInitParameters: {
	// A block that defines the CloudWatch Log Group that stores the evaluation events. See below.
	cloudwatchLogs?: [...#CloudwatchLogsInitParameters] @go(CloudwatchLogs,[]CloudwatchLogsInitParameters)

	// A block that defines the S3 bucket and prefix that stores the evaluation events. See below.
	s3Destination?: [...#S3DestinationInitParameters] @go(S3Destination,[]S3DestinationInitParameters)
}

#DataDeliveryObservation: {
	// A block that defines the CloudWatch Log Group that stores the evaluation events. See below.
	cloudwatchLogs?: [...#CloudwatchLogsObservation] @go(CloudwatchLogs,[]CloudwatchLogsObservation)

	// A block that defines the S3 bucket and prefix that stores the evaluation events. See below.
	s3Destination?: [...#S3DestinationObservation] @go(S3Destination,[]S3DestinationObservation)
}

#DataDeliveryParameters: {
	// A block that defines the CloudWatch Log Group that stores the evaluation events. See below.
	// +kubebuilder:validation:Optional
	cloudwatchLogs?: [...#CloudwatchLogsParameters] @go(CloudwatchLogs,[]CloudwatchLogsParameters)

	// A block that defines the S3 bucket and prefix that stores the evaluation events. See below.
	// +kubebuilder:validation:Optional
	s3Destination?: [...#S3DestinationParameters] @go(S3Destination,[]S3DestinationParameters)
}

#ProjectInitParameters: {
	// A block that contains information about where Evidently is to store evaluation events for longer term storage, if you choose to do so. If you choose not to store these events, Evidently deletes them after using them to produce metrics and other experiment results that you can view. See below.
	dataDelivery?: [...#DataDeliveryInitParameters] @go(DataDelivery,[]DataDeliveryInitParameters)

	// Specifies the description of the project.
	description?: null | string @go(Description,*string)

	// A name for the project.
	name?: null | string @go(Name,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#ProjectObservation: {
	// The number of ongoing experiments currently in the project.
	activeExperimentCount?: null | float64 @go(ActiveExperimentCount,*float64)

	// The number of ongoing launches currently in the project.
	activeLaunchCount?: null | float64 @go(ActiveLaunchCount,*float64)

	// The ARN of the project.
	arn?: null | string @go(Arn,*string)

	// The date and time that the project is created.
	createdTime?: null | string @go(CreatedTime,*string)

	// A block that contains information about where Evidently is to store evaluation events for longer term storage, if you choose to do so. If you choose not to store these events, Evidently deletes them after using them to produce metrics and other experiment results that you can view. See below.
	dataDelivery?: [...#DataDeliveryObservation] @go(DataDelivery,[]DataDeliveryObservation)

	// Specifies the description of the project.
	description?: null | string @go(Description,*string)

	// The number of experiments currently in the project. This includes all experiments that have been created and not deleted, whether they are ongoing or not.
	experimentCount?: null | float64 @go(ExperimentCount,*float64)

	// The number of features currently in the project.
	featureCount?: null | float64 @go(FeatureCount,*float64)

	// The ID has the same value as the arn of the project.
	id?: null | string @go(ID,*string)

	// The date and time that the project was most recently updated.
	lastUpdatedTime?: null | string @go(LastUpdatedTime,*string)

	// The number of launches currently in the project. This includes all launches that have been created and not deleted, whether they are ongoing or not.
	launchCount?: null | float64 @go(LaunchCount,*float64)

	// A name for the project.
	name?: null | string @go(Name,*string)

	// The current state of the project. Valid values are AVAILABLE and UPDATING.
	status?: null | string @go(Status,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#ProjectParameters: {
	// A block that contains information about where Evidently is to store evaluation events for longer term storage, if you choose to do so. If you choose not to store these events, Evidently deletes them after using them to produce metrics and other experiment results that you can view. See below.
	// +kubebuilder:validation:Optional
	dataDelivery?: [...#DataDeliveryParameters] @go(DataDelivery,[]DataDeliveryParameters)

	// Specifies the description of the project.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// A name for the project.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#S3DestinationInitParameters: {
	// The name of the bucket in which Evidently stores evaluation events.
	bucket?: null | string @go(Bucket,*string)

	// The bucket prefix in which Evidently stores evaluation events.
	prefix?: null | string @go(Prefix,*string)
}

#S3DestinationObservation: {
	// The name of the bucket in which Evidently stores evaluation events.
	bucket?: null | string @go(Bucket,*string)

	// The bucket prefix in which Evidently stores evaluation events.
	prefix?: null | string @go(Prefix,*string)
}

#S3DestinationParameters: {
	// The name of the bucket in which Evidently stores evaluation events.
	// +kubebuilder:validation:Optional
	bucket?: null | string @go(Bucket,*string)

	// The bucket prefix in which Evidently stores evaluation events.
	// +kubebuilder:validation:Optional
	prefix?: null | string @go(Prefix,*string)
}

// ProjectSpec defines the desired state of Project
#ProjectSpec: {
	v1.#ResourceSpec
	forProvider: #ProjectParameters @go(ForProvider)

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
	initProvider?: #ProjectInitParameters @go(InitProvider)
}

// ProjectStatus defines the observed state of Project.
#ProjectStatus: {
	v1.#ResourceStatus
	atProvider?: #ProjectObservation @go(AtProvider)
}

// Project is the Schema for the Projects API. Provides a CloudWatch Evidently Project resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Project: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	spec:    #ProjectSpec   @go(Spec)
	status?: #ProjectStatus @go(Status)
}

// ProjectList contains a list of Projects
#ProjectList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Project] @go(Items,[]Project)
}
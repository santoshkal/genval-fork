// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/cloudwatch/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ExcludeFilterInitParameters: {
	// An array that defines the metrics you want to exclude for this metric namespace
	metricNames?: [...null | string] @go(MetricNames,[]*string)

	// Name of the metric namespace in the filter.
	namespace?: null | string @go(Namespace,*string)
}

#ExcludeFilterObservation: {
	// An array that defines the metrics you want to exclude for this metric namespace
	metricNames?: [...null | string] @go(MetricNames,[]*string)

	// Name of the metric namespace in the filter.
	namespace?: null | string @go(Namespace,*string)
}

#ExcludeFilterParameters: {
	// An array that defines the metrics you want to exclude for this metric namespace
	// +kubebuilder:validation:Optional
	metricNames?: [...null | string] @go(MetricNames,[]*string)

	// Name of the metric namespace in the filter.
	// +kubebuilder:validation:Optional
	namespace?: null | string @go(Namespace,*string)
}

#IncludeFilterInitParameters: {
	// An array that defines the metrics you want to include for this metric namespace
	metricNames?: [...null | string] @go(MetricNames,[]*string)

	// Name of the metric namespace in the filter.
	namespace?: null | string @go(Namespace,*string)
}

#IncludeFilterObservation: {
	// An array that defines the metrics you want to include for this metric namespace
	metricNames?: [...null | string] @go(MetricNames,[]*string)

	// Name of the metric namespace in the filter.
	namespace?: null | string @go(Namespace,*string)
}

#IncludeFilterParameters: {
	// An array that defines the metrics you want to include for this metric namespace
	// +kubebuilder:validation:Optional
	metricNames?: [...null | string] @go(MetricNames,[]*string)

	// Name of the metric namespace in the filter.
	// +kubebuilder:validation:Optional
	namespace?: null | string @go(Namespace,*string)
}

#IncludeMetricInitParameters: {
	// The name of the metric.
	metricName?: null | string @go(MetricName,*string)

	// The namespace of the metric.
	namespace?: null | string @go(Namespace,*string)
}

#IncludeMetricObservation: {
	// The name of the metric.
	metricName?: null | string @go(MetricName,*string)

	// The namespace of the metric.
	namespace?: null | string @go(Namespace,*string)
}

#IncludeMetricParameters: {
	// The name of the metric.
	// +kubebuilder:validation:Optional
	metricName?: null | string @go(MetricName,*string)

	// The namespace of the metric.
	// +kubebuilder:validation:Optional
	namespace?: null | string @go(Namespace,*string)
}

#MetricStreamInitParameters: {
	// List of exclusive metric filters. If you specify this parameter, the stream sends metrics from all metric namespaces except for the namespaces and the conditional metric names that you specify here. If you don't specify metric names or provide empty metric names whole metric namespace is excluded. Conflicts with include_filter.
	excludeFilter?: [...#ExcludeFilterInitParameters] @go(ExcludeFilter,[]ExcludeFilterInitParameters)

	// List of inclusive metric filters. If you specify this parameter, the stream sends only the conditional metric names from the metric namespaces that you specify here. If you don't specify metric names or provide empty metric names whole metric namespace is included. Conflicts with exclude_filter.
	includeFilter?: [...#IncludeFilterInitParameters] @go(IncludeFilter,[]IncludeFilterInitParameters)

	// account observability.
	includeLinkedAccountsMetrics?: null | bool @go(IncludeLinkedAccountsMetrics,*bool)

	// Friendly name of the metric stream. Conflicts with name_prefix.
	name?: null | string @go(Name,*string)

	// Output format for the stream. Possible values are json and opentelemetry0.7. For more information about output formats, see Metric streams output formats.
	outputFormat?: null | string @go(OutputFormat,*string)

	// For each entry in this array, you specify one or more metrics and the list of additional statistics to stream for those metrics. The additional statistics that you can stream depend on the stream's output_format. If the OutputFormat is json, you can stream any additional statistic that is supported by CloudWatch, listed in CloudWatch statistics definitions. If the OutputFormat is opentelemetry0.7, you can stream percentile statistics (p99 etc.). See details below.
	statisticsConfiguration?: [...#StatisticsConfigurationInitParameters] @go(StatisticsConfiguration,[]StatisticsConfigurationInitParameters)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#MetricStreamObservation: {
	// ARN of the metric stream.
	arn?: null | string @go(Arn,*string)

	// Date and time in RFC3339 format that the metric stream was created.
	creationDate?: null | string @go(CreationDate,*string)

	// List of exclusive metric filters. If you specify this parameter, the stream sends metrics from all metric namespaces except for the namespaces and the conditional metric names that you specify here. If you don't specify metric names or provide empty metric names whole metric namespace is excluded. Conflicts with include_filter.
	excludeFilter?: [...#ExcludeFilterObservation] @go(ExcludeFilter,[]ExcludeFilterObservation)

	// ARN of the Amazon Kinesis Firehose delivery stream to use for this metric stream.
	firehoseArn?: null | string @go(FirehoseArn,*string)
	id?:          null | string @go(ID,*string)

	// List of inclusive metric filters. If you specify this parameter, the stream sends only the conditional metric names from the metric namespaces that you specify here. If you don't specify metric names or provide empty metric names whole metric namespace is included. Conflicts with exclude_filter.
	includeFilter?: [...#IncludeFilterObservation] @go(IncludeFilter,[]IncludeFilterObservation)

	// account observability.
	includeLinkedAccountsMetrics?: null | bool @go(IncludeLinkedAccountsMetrics,*bool)

	// Date and time in RFC3339 format that the metric stream was last updated.
	lastUpdateDate?: null | string @go(LastUpdateDate,*string)

	// Friendly name of the metric stream. Conflicts with name_prefix.
	name?: null | string @go(Name,*string)

	// Output format for the stream. Possible values are json and opentelemetry0.7. For more information about output formats, see Metric streams output formats.
	outputFormat?: null | string @go(OutputFormat,*string)

	// ARN of the IAM role that this metric stream will use to access Amazon Kinesis Firehose resources. For more information about role permissions, see Trust between CloudWatch and Kinesis Data Firehose.
	roleArn?: null | string @go(RoleArn,*string)

	// State of the metric stream. Possible values are running and stopped.
	state?: null | string @go(State,*string)

	// For each entry in this array, you specify one or more metrics and the list of additional statistics to stream for those metrics. The additional statistics that you can stream depend on the stream's output_format. If the OutputFormat is json, you can stream any additional statistic that is supported by CloudWatch, listed in CloudWatch statistics definitions. If the OutputFormat is opentelemetry0.7, you can stream percentile statistics (p99 etc.). See details below.
	statisticsConfiguration?: [...#StatisticsConfigurationObservation] @go(StatisticsConfiguration,[]StatisticsConfigurationObservation)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#MetricStreamParameters: {
	// List of exclusive metric filters. If you specify this parameter, the stream sends metrics from all metric namespaces except for the namespaces and the conditional metric names that you specify here. If you don't specify metric names or provide empty metric names whole metric namespace is excluded. Conflicts with include_filter.
	// +kubebuilder:validation:Optional
	excludeFilter?: [...#ExcludeFilterParameters] @go(ExcludeFilter,[]ExcludeFilterParameters)

	// ARN of the Amazon Kinesis Firehose delivery stream to use for this metric stream.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/firehose/v1beta1.DeliveryStream
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",false)
	// +kubebuilder:validation:Optional
	firehoseArn?: null | string @go(FirehoseArn,*string)

	// Reference to a DeliveryStream in firehose to populate firehoseArn.
	// +kubebuilder:validation:Optional
	firehoseArnRef?: null | v1.#Reference @go(FirehoseArnRef,*v1.Reference)

	// Selector for a DeliveryStream in firehose to populate firehoseArn.
	// +kubebuilder:validation:Optional
	firehoseArnSelector?: null | v1.#Selector @go(FirehoseArnSelector,*v1.Selector)

	// List of inclusive metric filters. If you specify this parameter, the stream sends only the conditional metric names from the metric namespaces that you specify here. If you don't specify metric names or provide empty metric names whole metric namespace is included. Conflicts with exclude_filter.
	// +kubebuilder:validation:Optional
	includeFilter?: [...#IncludeFilterParameters] @go(IncludeFilter,[]IncludeFilterParameters)

	// account observability.
	// +kubebuilder:validation:Optional
	includeLinkedAccountsMetrics?: null | bool @go(IncludeLinkedAccountsMetrics,*bool)

	// Friendly name of the metric stream. Conflicts with name_prefix.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Output format for the stream. Possible values are json and opentelemetry0.7. For more information about output formats, see Metric streams output formats.
	// +kubebuilder:validation:Optional
	outputFormat?: null | string @go(OutputFormat,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// ARN of the IAM role that this metric stream will use to access Amazon Kinesis Firehose resources. For more information about role permissions, see Trust between CloudWatch and Kinesis Data Firehose.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/iam/v1beta1.Role
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.ARNExtractor()
	// +kubebuilder:validation:Optional
	roleArn?: null | string @go(RoleArn,*string)

	// Reference to a Role in iam to populate roleArn.
	// +kubebuilder:validation:Optional
	roleArnRef?: null | v1.#Reference @go(RoleArnRef,*v1.Reference)

	// Selector for a Role in iam to populate roleArn.
	// +kubebuilder:validation:Optional
	roleArnSelector?: null | v1.#Selector @go(RoleArnSelector,*v1.Selector)

	// For each entry in this array, you specify one or more metrics and the list of additional statistics to stream for those metrics. The additional statistics that you can stream depend on the stream's output_format. If the OutputFormat is json, you can stream any additional statistic that is supported by CloudWatch, listed in CloudWatch statistics definitions. If the OutputFormat is opentelemetry0.7, you can stream percentile statistics (p99 etc.). See details below.
	// +kubebuilder:validation:Optional
	statisticsConfiguration?: [...#StatisticsConfigurationParameters] @go(StatisticsConfiguration,[]StatisticsConfigurationParameters)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#StatisticsConfigurationInitParameters: {
	// The additional statistics to stream for the metrics listed in include_metrics.
	additionalStatistics?: [...null | string] @go(AdditionalStatistics,[]*string)

	// An array that defines the metrics that are to have additional statistics streamed. See details below.
	includeMetric?: [...#IncludeMetricInitParameters] @go(IncludeMetric,[]IncludeMetricInitParameters)
}

#StatisticsConfigurationObservation: {
	// The additional statistics to stream for the metrics listed in include_metrics.
	additionalStatistics?: [...null | string] @go(AdditionalStatistics,[]*string)

	// An array that defines the metrics that are to have additional statistics streamed. See details below.
	includeMetric?: [...#IncludeMetricObservation] @go(IncludeMetric,[]IncludeMetricObservation)
}

#StatisticsConfigurationParameters: {
	// The additional statistics to stream for the metrics listed in include_metrics.
	// +kubebuilder:validation:Optional
	additionalStatistics: [...null | string] @go(AdditionalStatistics,[]*string)

	// An array that defines the metrics that are to have additional statistics streamed. See details below.
	// +kubebuilder:validation:Optional
	includeMetric: [...#IncludeMetricParameters] @go(IncludeMetric,[]IncludeMetricParameters)
}

// MetricStreamSpec defines the desired state of MetricStream
#MetricStreamSpec: {
	v1.#ResourceSpec
	forProvider: #MetricStreamParameters @go(ForProvider)

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
	initProvider?: #MetricStreamInitParameters @go(InitProvider)
}

// MetricStreamStatus defines the observed state of MetricStream.
#MetricStreamStatus: {
	v1.#ResourceStatus
	atProvider?: #MetricStreamObservation @go(AtProvider)
}

// MetricStream is the Schema for the MetricStreams API. Provides a CloudWatch Metric Stream resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#MetricStream: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.outputFormat) || (has(self.initProvider) && has(self.initProvider.outputFormat))",message="spec.forProvider.outputFormat is a required parameter"
	spec:    #MetricStreamSpec   @go(Spec)
	status?: #MetricStreamStatus @go(Status)
}

// MetricStreamList contains a list of MetricStreams
#MetricStreamList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#MetricStream] @go(Items,[]MetricStream)
}
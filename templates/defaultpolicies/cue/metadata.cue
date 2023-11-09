package k8s

#Metadata: {
	name:      *"genval" | string
	namespace: *"genval" | string
	labels: {
		app: string | *"genval"
		env: *"mytest" | string
	}
	...
}

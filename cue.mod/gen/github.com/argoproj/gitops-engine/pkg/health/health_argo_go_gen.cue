// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/argoproj/gitops-engine/pkg/health

package health

_#nodePhase: string

_#nodePending:   _#nodePhase & "Pending"
_#nodeRunning:   _#nodePhase & "Running"
_#nodeSucceeded: _#nodePhase & "Succeeded"
_#nodeFailed:    _#nodePhase & "Failed"
_#nodeError:     _#nodePhase & "Error"

// An agnostic workflow object only considers Status.Phase and Status.Message. It is agnostic to the API version or any
// other fields.
_#argoWorkflow: {
	Status: {
		Phase: _#nodePhase, Message: string
	} @go(,struct{Phase nodePhase; Message string})
}
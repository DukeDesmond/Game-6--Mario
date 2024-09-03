extends Label

@export var status : StateMachine

func _process(delta: float) -> void:
	self.text = "State : " + status.current_state.name

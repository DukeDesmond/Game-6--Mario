extends Label

@export var status : CharacterStateMachine

func _process(delta: float) -> void:
	self.text = "State : " + status.current_state.name

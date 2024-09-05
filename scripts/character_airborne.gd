class_name Airborne extends State

# Called when the node enters the scene tree for the first time.
func enter():
	if !player:
		push_warning("Player not exported in Airborne State!")

func exit():
	pass
	
func state_process(delta):
	if player.life <= 0:
		transitioned.emit(self,"Death")

func state_physics_process(delta):
	if player.is_on_floor():
		if player.knockback == true:
			player.knockback = false
		playback.travel("jump_end")
		transitioned.emit(self,"Grounded")
	
func state_input(event : InputEvent):
	pass

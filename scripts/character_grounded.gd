class_name Grounded extends State


const JUMP_VELOCITY = -400.0

# Called when the node enters the scene tree for the first time.
func enter():
	if !player:
		push_warning("Player not exported in Grounded State!")
	player.can_move = true

func exit():
	pass
	
func state_process(delta):
	if player.life <= 0:
		transitioned.emit(self,"Death")
	
	elif !player.is_on_floor():
		playback.travel("in_air")
		transitioned.emit(self,"Airborne")

func state_physics_process(delta):
	pass
	
func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		player.velocity.y = JUMP_VELOCITY
		state_jump()
	
	elif event.is_action_pressed("attack"):
		attack()

func state_jump():
	playback.travel("jump_start")
	transitioned.emit(self,"Airborne")
	
func attack():
	transitioned.emit(self, "Attack")


func _on_player_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("add_player"):
		var dir =  player.global_position.direction_to(body.global_position).x
		if dir < 0:
			dir = -1
		else:
			dir = 1
		player.velocity = Vector2(-dir * 200,-100)
		player.knockback = true
		player.hit()

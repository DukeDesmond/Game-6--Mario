class_name Player extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var state_machine: StateMachine = $StateMachine


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO

func _ready() -> void:
	animation_tree.active = true
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction != Vector2.ZERO:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = 0
	
	
	update_facing_direction()
	update_animation()
	move_and_slide()


func update_animation():
	animation_tree.set("parameters/move/blend_position",direction.x)

func update_facing_direction():
	if direction.x > 0:
		sprite_2d.flip_h = false
	elif direction.x < 0:
		sprite_2d.flip_h = true

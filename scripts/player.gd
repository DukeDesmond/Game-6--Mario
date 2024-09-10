class_name Player extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var sword_hit_box: CollisionShape2D = $SwordArea2d/SwordHitBox
@onready var player_collision_shape_2d: CollisionShape2D = $PlayerCollisionShape2D
@onready var area_collision_shape_2d: CollisionShape2D = $PlayerArea2D/AreaCollisionShape2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var can_move : bool = true
var life : int = 3
var knockback : bool = false
var dead = false


func _ready() -> void:
	animation_tree.active = true
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and dead == false:
		velocity += get_gravity() * delta
		pass

	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction != Vector2.ZERO and can_move == true and knockback == false:
		velocity.x = direction.x * SPEED
		update_facing_direction()
	elif knockback == false:
		velocity.x = 0
		
	update_animation()
	move_and_slide()


func update_animation():
	if can_move == true:
		animation_tree.set("parameters/move/blend_position",direction.x)

func update_facing_direction():
	if direction.x == 0:
		return
	sprite_2d.flip_h = direction.x < 0
	sword_hit_box.position.x = 28 * direction.x

func _on_sword_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("death"):
		body.death()
		
func hit():
	life -=1

func death():
	dead = true
	area_collision_shape_2d.disabled = true
	player_collision_shape_2d.disabled = true
	velocity = Vector2.ZERO

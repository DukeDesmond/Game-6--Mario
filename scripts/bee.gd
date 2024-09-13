class_name bee extends CharacterBody2D



@onready var behavior_timer: Timer = $BehaviorTimer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var bee_area_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var bee_sight_2d: CollisionShape2D = $CircleOfSight/CollisionShape2D
@onready var bee_shape_2d: CollisionShape2D = $CollisionShape2D


const SPEED : int = 50

var score_label : Label
var vector : Vector2 = Vector2.ZERO
var chase: bool = false
var player: CharacterBody2D = null
var life : int = 1
var dead : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	bee_shape_2d.disabled = false
	bee_area_2d.disabled = false
	bee_sight_2d.disabled = false
	
func _physics_process(delta: float) -> void:
	if chase == true and player.dead == false:
		vector = position.direction_to(player.position)
	
	velocity += vector * SPEED * delta
	
	if dead == false:
		update_facing_direction()
		move_and_slide()

func _on_behavior_timer_timeout() -> void:

	behavior_timer.wait_time = random([0.2, 0.5, 0.7])
	if chase == false:
		vector = random([Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT])

func random(array : Array):
	array.shuffle()
	return array.front() 

func update_facing_direction():
	if velocity.x < 0:
		sprite_2d.flip_h = false

	elif velocity.x > 0:
		sprite_2d.flip_h = true
		
func add_player(character:CharacterBody2D):
	player = character



func _on_circle_of_sight_body_entered(body: Node2D) -> void:
	if body.name == "Player":
			chase = true


func _on_circle_of_sight_body_exited(body: Node2D) -> void:
	if body.name == "Player":
			chase = false
			#
func death():
		life -=1
		if life <= 0:
			score_label.add_score(200)
			dead = true
			animation_tree["parameters/playback"].travel("death")


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		queue_free()

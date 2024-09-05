class_name bee extends CharacterBody2D

@onready var behavior_timer: Timer = $BehaviorTimer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree


const SPEED : int = 50

var vector : Vector2 = Vector2.ZERO
var direction : int
var chase: bool = false
var player: CharacterBody2D = null
var life : int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if chase:
		vector = position.direction_to(player.position)
	
	velocity += vector * SPEED * delta
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
		direction = 1

	elif velocity.x > 0:
		sprite_2d.flip_h = true
		direction = -1
		
func add_player(character:CharacterBody2D):
	player = character



func _on_circle_of_sight_body_entered(body: Node2D) -> void:
	if body.name == "Player":
			chase = true


func _on_circle_of_sight_body_exited(body: Node2D) -> void:
	if body.name == "Player":
			chase = false
			#
#func death():
		#life -=1
		#if life <= 0:
			#bee_shape_2d.disabled = true
			#direction = 0
			#animation_tree["parameters/playback"].travel("death")

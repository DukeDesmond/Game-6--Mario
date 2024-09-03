extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var ray_cast_wall: RayCast2D = $RayCastWall
@onready var ray_cast_floor: RayCast2D = $RayCastFloor
@onready var time_slice: Timer = $TimeSlice
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var behavior_timer: Timer = $BehaviorTimer
@onready var line_of_sight_box: CollisionShape2D = $LineOfSightArea/LineOfSightBox
@onready var boar_shape_2d: CollisionShape2D = $BoarShape2D

var checked_surrounding : bool = false
var speed : float = 75
var direction : int = -1
var life : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_tree.active = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if checked_surrounding == false:
		checked_surrounding = true
		if !ray_cast_floor.is_colliding():
			direction *= -1
			update_facing_direction()
		
		elif ray_cast_wall.is_colliding():
			direction *= -1
			update_facing_direction()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	velocity.x = direction * speed
	

	update_animation()
	move_and_slide()
	
func update_facing_direction():
	if direction < 0:
		sprite_2d.flip_h = false
		ray_cast_floor.position *= -1
		ray_cast_wall.target_position *= -1
		line_of_sight_box.position *= -1
		
	elif direction > 0:
		sprite_2d.flip_h = true
		ray_cast_floor.position *= -1
		ray_cast_wall.target_position *= -1
		line_of_sight_box.position *= -1
		
func update_animation():
	animation_tree.set("parameters/move/blend_position",direction)


func _on_time_slice_timeout() -> void:
	checked_surrounding = false
	time_slice.start(0.1)


func _on_line_of_sight_area_body_entered(body: Node2D) -> void:
	animation_tree["parameters/playback"].travel("run")
	speed = 350

func _on_line_of_sight_area_body_exited(body: Node2D) -> void:
	behavior_timer.start()

func _on_behavior_timer_timeout() -> void:
	animation_tree["parameters/playback"].travel("move")
	speed = 75
	
func death():
		life -=1
		if life <= 0:
			boar_shape_2d.disabled = true
			direction = 0
			animation_tree["parameters/playback"].travel("death")


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name =="death":
		queue_free()

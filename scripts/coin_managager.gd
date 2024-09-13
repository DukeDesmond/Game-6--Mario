extends Node2D

@export var score_label : Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is AnimatedSprite2D:
			child.score_label = score_label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

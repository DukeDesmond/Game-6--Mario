extends Node2D

@export var score_label : Label
@export var player : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child.has_method("add_player"):
			child.add_player(player)
			child.score_label = score_label

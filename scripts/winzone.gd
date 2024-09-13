extends Area2D

@onready var label: Label = $Label
@onready var restart: Button = $Restart

func _ready() -> void:
	Engine.time_scale = 1
	label.text = "Goal"
	restart.hide()
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		label.text = "You Win"
		restart.show()
		Engine.time_scale = 0

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

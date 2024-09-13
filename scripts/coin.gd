extends AnimatedSprite2D

var score_label : Label
@onready var area_2d: Area2D = $Area2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		score_label.add_score(10)
		audio_stream_player_2d.play()
		visible = false

func _on_audio_stream_player_2d_finished() -> void:
	queue_free()

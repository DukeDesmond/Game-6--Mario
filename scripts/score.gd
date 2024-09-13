extends Label

var score : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Score: 0"


func add_score( add : int = 100):
	score += add
	text = "Score: " + str(score)
	

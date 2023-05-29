extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var nexText = 0
var FirstTime = true
var textToGo = [
	["Welcome to the tutorial, if you're seeing this text, you're learning how to play the game!\n\n[Press ENTER to continue]"],
	["Move around using WASD and press MOUSE to fire!"]
]

func _ready():
	get_tree().paused = true
	visible_characters = 0

var lapsed = 0
func _process(delta):
	if (Input.is_action_just_pressed("ui_accept") || FirstTime):
		FirstTime = false
		if visible_characters < text.length():
			visible_characters = text.length()
			lapsed = text.length() * 0.05
		else:
			if (nexText!=textToGo.size()):
					visible_characters = 0
					lapsed = 0
					text = textToGo[nexText][0]
					nexText += 1
			else:
				get_tree().paused = false
				get_parent().queue_free()
				pass
	lapsed += delta
	visible_characters = lapsed/0.05

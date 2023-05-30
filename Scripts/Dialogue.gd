extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var nexText = 0
var FirstTime = true
var textToGo = [
	["You should never see this text! If you do, there is a bug! You should report it immediately!"]
]

signal dialogue_finished

func _ready():
	get_tree().paused = true
	visible_characters = 0

func setup(input):
	textToGo = loadJSON(input).script

var lapsed = 0

func loadJSON(path) -> Dictionary:
	var file = File.new()
	file.open(path, file.READ)
	var dialogue = parse_json(file.get_as_text())
	return dialogue

func _process(delta):
	if (Input.is_action_just_pressed("ui_accept") || FirstTime):
		FirstTime = false
		if visible_characters < text.length() - 30:
			visible_characters = text.length()
			lapsed = text.length() * 0.025
		else:
			if (nexText!=textToGo.size()):
					visible_characters = 0
					lapsed = 0
					text = textToGo[nexText]
					nexText += 1
			else:
				get_tree().paused = false
				emit_signal("dialogue_finished")
				get_parent().queue_free()
				pass
	lapsed += delta
	visible_characters = lapsed/0.025

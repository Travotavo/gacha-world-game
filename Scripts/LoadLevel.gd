extends Control


# Declare member variables here. Examples:
# var a = 2
export var Level:String
export var Tag:int
onready var save = SaveManager.game_dat

# Called when the node enters the scene tree for the first time.
func _ready():
	if Tag != 4:
		if save.worlds[Tag]:
			visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	return get_tree().change_scene(Level)

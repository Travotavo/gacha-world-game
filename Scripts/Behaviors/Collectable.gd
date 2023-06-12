extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var id:String
export var opt_level:int
export var mainMenu = true
onready var save = SaveManager.game_dat
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	 # Replace with function body.
	if area.is_in_group("Player"):
		if opt_level != 4:
			save.worlds[opt_level] = true
		save.collectables[id] = 0
		SaveManager.save_data()
		if mainMenu:
			return get_tree().change_scene("res://Assets/Menus/Main Menu.tscn")
		else:
			queue_free()

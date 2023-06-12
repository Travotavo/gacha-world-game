extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var healthy = preload("res://Assets/Textures/UI/Game/heart.png")
var damage = preload("res://Assets/Textures/UI/Game/heartbroke.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var currHP = 3

func updateHP(newVal):
	match newVal:
		1:
			$Heart.texture = healthy
			$Heart2.texture = damage
			$Heart3.texture = damage
		2:
			$Heart.texture = healthy
			$Heart2.texture = healthy
			$Heart3.texture = damage
		3:
			
			$Heart.texture = healthy
			$Heart2.texture = healthy
			$Heart3.texture = healthy

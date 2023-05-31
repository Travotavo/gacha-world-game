extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var id:String

signal Collectable_got
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	 # Replace with function body.
	if area.is_in_group("Player"):
		emit_signal("Collectable_got", id)
		queue_free()

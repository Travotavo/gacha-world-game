extends Node2D

export var Model_Path = ""
export var Collectable_Tag = ""
export var Target_Path:NodePath



onready var Target = get_node(Target_Path)
onready var save = SaveManager.game_dat
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if save.collectables.has(Collectable_Tag):
		$Sprite.visible = false
		$ViewportContainer.visible = true
	var model = load(Model_Path)
	var temp = model.instance()
	$ViewportContainer/Viewport/Target.call_deferred("add_child",temp)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

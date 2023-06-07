extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var save = SaveManager.game_dat

# Called when the node enters the scene tree for the first time.
func _ready():
	if not save.tutorial:
		$UI/CollectionUI.visible = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Input.is_action_just_pressed("ui_accept")):
		$AnimationPlayer.play("CamSpin")
		$UI.visible = true


func _on_Go_Button_button_down():
	$AnimationPlayer.play("Dispense")
	$UI.visible = false
	$CrankSounds.play()

func loadLevel():
	if not save.tutorial:
		return get_tree().change_scene("res://Assets/Prefabs/Levels/Tutorial.tscn")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Dispense":
		$AnimationPlayer.play("Enter")

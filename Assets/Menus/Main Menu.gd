extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var save = SaveManager.game_dat
var introdone = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if not save.tutorial:
		$UI/CollectionUI.visible = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Input.is_action_just_pressed("ui_end")):
		get_tree().quit()
	if (Input.is_action_just_pressed("ui_accept")) && not introdone:
		$AnimationPlayer.play("CamSpin")
		introdone = true
		$UI.visible = true


func _on_Go_Button_button_down():
	$AnimationPlayer.play("Dispense")
	$UI.visible = false
	$CrankSounds.play()

func loadLevel():
	if not save.tutorial:
		return get_tree().change_scene("res://Assets/Prefabs/Levels/Tutorial.tscn")
	else:
		return _dispense_random()

var worlds = [
	"res://Assets/Prefabs/Levels/Ghost-Town.tscn",
	"res://Assets/Prefabs/Levels/NopNop.tscn",
	"res://Assets/Prefabs/Levels/Hacked-Laptop.tscn"
]
func _dispense_random():
	randomize()
	var countdown = save.worlds.size() - 1
	var clone = [] + worlds
	while countdown > 0:
		if save.worlds[countdown]:
			clone.remove(countdown)
		countdown -= 1
	if clone.size() == 0:
		var rand_world:int = randi() % worlds.size()
		print(rand_world)
		return get_tree().change_scene(worlds[rand_world])
	else:
		var rand_world:int = randi() % clone.size()
		print(rand_world)
		return get_tree().change_scene(clone[rand_world])

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Dispense":
		$AnimationPlayer.play("Enter")

extends Node2D

export var CheckpointsArr:Array
export var UIPath:NodePath
export var CamPath:NodePath
onready var CamPoint = get_node(CamPath)
var Dialogue_Prefab = preload("res://Assets/Prefabs/UIs/UI Scenes/DialoguePop.tscn")
var pace = 0
var loadedArrPos = 0
var preloadArr = [0,0,0,0,0,0,0,0]

func _ready():
	var temp = 0
	for i in CheckpointsArr:
		if i == null:
			break
		if i[0] == 1:
			preloadArr[temp] = load(i[1])
			temp += 1
	if CheckpointsArr.size() != 0:
		processCheckpoint()

func processCheckpoint():
	match CheckpointsArr[pace][0]:
		0: #Dialogue data
			var Dialogue_Instance = Dialogue_Prefab.instance()
			Dialogue_Instance.get_child(0).setup(CheckpointsArr[pace][1])
			Dialogue_Instance.get_child(0).connect("dialogue_finished", self, "advanceArr")
			get_node(UIPath).get_child(0).add_child(Dialogue_Instance)
			pass
		1: #Wave data
			var blueprint = preloadArr[loadedArrPos]
			loadedArrPos += 1
			var wave = blueprint.instance()
			add_child(wave)
			wave.position = CamPoint.position
			wave.connect("enemies_defeated", self, "advanceArr")
			pass
		2: #Walking point
			pass

func advanceArr():
	pace += 1
	#Run Checkpoint Data Here
	processCheckpoint()
	pass

func _on_EnemyBox_enemies_defeated():
	advanceArr()


func _on_Player_player_died():
	get_tree().change_scene("res://Assets/Menus/Temp_Lose.tscn")

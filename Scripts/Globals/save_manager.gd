extends Node


const SAVE_PATH = "Save/save.dat"
var game_dat = {}

func _ready():
	load_data()

func save_data():
	var file = File.new()
	file.open(SAVE_PATH, file.WRITE)
	file.store_var(game_dat)
	file.close()

func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_PATH):
		game_dat = {
			"tutorial": false,
			"worlds": [false, false, false],
			"collectables": {
				"default": 0
			}
		}
		save_data()
	file.open(SAVE_PATH, File.READ)
	game_dat = file.get_var()
	file.close()

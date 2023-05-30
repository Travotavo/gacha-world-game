extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var enemies_path: NodePath
onready var enemies = get_node(enemies_path)

signal enemies_defeated

func _ready():
	print("Oopsie")
	for i in self.get_children():
		i.connect("enemy_defeated", self, "_enemy_check")

func _enemy_check():
	print("Enemy Died!")
	if get_child_count()-1 == 0:
		emit_signal("enemies_defeated")

#Not needed yet, but added for clarity on manager's purpose/functionality
func _add_enemy(enemy):
	enemy.connect("enemy_defeated", self, "_enemy_check")
	add_child(enemy)

extends Node2D



func _on_EnemyBox_enemies_defeated():
	get_tree().change_scene("res://Assets/Menus/Temp_Win.tscn")


func _on_Player_player_died():
	get_tree().change_scene("res://Assets/Menus/Temp_Lose.tscn")

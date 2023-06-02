extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var hp = 10
export var hpMax = 10
export var speed = 20
var movespeed=200
var bulletspeed=1000
var bullet=preload("res://Assets/Prefabs/Enemies/Enemy Bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	fire_arrow()
	pass # Replace with function body.

func _on_HurtBox_area_entered(area):
	if area.is_in_group("Bullet"):
		$Node2D/ColorRect2.visible = true
		hp -= 1
		updateHP()
	if hp == 0:
		emit_signal("enemy_defeated")
		queue_free()
		
		
func updateHP():
	$Node2D/ColorRect2/ColorRect.rect_size.x = lerp(0,40,(float(hp)/hpMax))

func fire_arrow():
	var bullet_in=bullet.instance()
	bullet_in.position = $Node2D.get_global_position()
	bullet_in.rotation_degrees= $Node2D.rotation
	bullet_in.apply_impulse(Vector2(),Vector2(bulletspeed,0).rotated($Node2D.rotation))
	get_tree().get_root().call_deferred("add_child",bullet_in)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

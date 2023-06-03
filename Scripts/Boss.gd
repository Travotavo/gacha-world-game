extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hp = 10
var hpMax = 10
var speed = 20
var movespeed=200
var bulletspeed=500
var bullet=preload("res://Assets/Prefabs/Enemies/Enemy Bullet.tscn")
export var awake = true
# Called when the node enters the scene tree for the first time.
func _ready():
	if awake:
		$Sprite.modulate = Color.white
	fire_arrow() # Replace with function body.

func _on_HurtBox_area_entered(area):
	print(awake)
	print(area.is_in_group("Bullet"))
	if area.is_in_group("Bullet") and awake:
		
		$Node2D/ColorRect2.visible = true
		hp -= 1
		updateHP()
	if hp == 0:
		emit_signal("boss_defeated")
		queue_free()
		
		
func updateHP():
	$Node2D/ColorRect2/ColorRect.rect_size.x = lerp(0,40,(float(hp)/hpMax))

func fire_arrow():
	var bullet_in=bullet.instance()
	bullet_in.position = $Gun/Sprite.get_global_position()
	bullet_in.rotation_degrees= $Gun.rotation
	bullet_in.apply_impulse(Vector2(),Vector2(bulletspeed,0))
	get_tree().get_root().call_deferred("add_child",bullet_in)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hp = 10
var hpMax = 10
var speed = 20
var movespeed=200
var bulletspeed=200
var bullet=preload("res://Assets/Prefabs/Enemies/Enemy Bullet.tscn")
export var awake = true
# Called when the node enters the scene tree for the first time.
func _ready():
	if awake:
		$Sprite.modulate = Color.white
	fire_arrow(1) # Replace with function body.

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

func fire_bullet(direction,x_offset,y_offset,angle):
	#1=right
	#2=up
	#3=left
	#4=down
	var bullet_in=bullet.instance()
	if(direction==1):
		bullet_in.position = Vector2($right/Sprite.get_global_position().x+x_offset, $right/Sprite.get_global_position().y+y_offset)
		bullet_in.rotation_degrees= $right.rotation
	if(direction==2):
		bullet_in.position = Vector2($up/Sprite.get_global_position().x+x_offset, $up/Sprite.get_global_position().y+y_offset)
		bullet_in.rotation_degrees= $up.rotation
	if(direction==3):
		bullet_in.position = Vector2($left/Sprite.get_global_position().x+x_offset, $left/Sprite.get_global_position().y+y_offset)
		bullet_in.rotation_degrees= $left.rotation
	if(direction==4):
		bullet_in.position = Vector2($down/Sprite.get_global_position().x+x_offset, $down/Sprite.get_global_position().y+y_offset)
		bullet_in.rotation_degrees= $down.rotation
	#bullet_in.position.x+offset;
	#bullet_in.position.y+offset;
	
	bullet_in.apply_impulse(Vector2(),Vector2(bulletspeed,angle))
	get_tree().get_root().call_deferred("add_child",bullet_in)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func fire_arrow(direction):
	fire_bullet(direction,0,10,180);
	fire_bullet(direction,0,-10,-180);
	fire_bullet(direction,0,0,0);

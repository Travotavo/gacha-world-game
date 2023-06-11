extends KinematicBody2D

onready var save = SaveManager.game_dat
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hp = 4
var hpMax = 4
var speed = 0
var movespeed=0
var bulletspeed=200
var time=4
var bullet=preload("res://Assets/Prefabs/Enemies/Enemy Bullet.tscn")
export var awake = false
var timer := Timer.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	if awake:
		$Sprite.modulate = Color.white
		$WakeBox.queue_free()
		



func _on_HurtBox_area_entered(area):
	#print(awake)
	#print(area.is_in_group("Bullet"))
	if area.is_in_group("Bullet") and awake:
		
		$Node2D/ColorRect2.visible = true
		hp -= 1
		updateHP()
	if hp == 0:
		save.tutorial = true
		SaveManager.save_data()
		emit_signal("enemy_defeated")
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
	
	bullet_in.apply_impulse(Vector2(),Vector2(bulletspeed,0).rotated(angle))
	get_tree().get_root().call_deferred("add_child",bullet_in)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func fire_arrow(direction):
	if(direction==1):
		fire_bullet(direction,0,10,0.785398);
		fire_bullet(direction,0,-10,-0.785398);
		fire_bullet(direction,0,0,0);
	elif(direction==2):
		fire_bullet(direction,10,0,-0.78539816339);
		fire_bullet(direction,-10,0,-3.14159265359*3/4);
		fire_bullet(direction,0,0,-3.14159265359/2);
	elif(direction==3):
		fire_bullet(direction,0,10,3.14159265359*3/4);
		fire_bullet(direction,0,-10,-3.14159265359*3/4);
		fire_bullet(direction,0,0,3.14159265359);
	elif(direction==4):
		fire_bullet(direction,10,0,0.78539816339);
		fire_bullet(direction,-10,0,3.14159265359*3/4);
		fire_bullet(direction,0,0,3.14159265359/2);


func _on_timer_timeout() -> void:
	print("QwQ")
	
	fire_bullet(4,0,10,deg2rad(randi()%180)*1);
	if(hp<0):
		timer.one_shot = true


func _on_WakeBox_area_entered(area):
	if area.is_in_group("Player"):
		print("screeeeeeeee");
		$Sprite.modulate = Color.white
		awake = true
		add_child(timer)
		timer.one_shot = false
		timer.start()
		timer.connect("timeout", self, "_on_timer_timeout")

extends KinematicBody2D
#set camera to center around player
#fix enemy movement

signal player_died
signal player_hurt

var HP = 5
var movespeed=200
var bulletspeed=1000
var bullet=preload("res://Assets/Prefabs/Player/Bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("player_hurt", $CanvasLayer/PlayerHP, "updateHP")
	Global.set("player", self)
	

func _physics_process(delta):
	var motion=Vector2()
	
	if Input.is_action_pressed("move_up") and position.y > -250:
		$AnimationPlayer.play("Up")
		motion.y-=1
	if Input.is_action_pressed("move_down") and position.y < 270:
		$AnimationPlayer.play("Down")
		motion.y+=1
	if Input.is_action_pressed("move_left"):
		$AnimationPlayer.play("Left")
		motion.x-=1
	if Input.is_action_pressed("move_right"):
		$AnimationPlayer.play("Right")
		motion.x+=1
	motion=motion.normalized()
	motion=move_and_slide(motion*movespeed)
	$Gun.look_at(get_global_mouse_position())
	
	if(Input.is_action_just_pressed("action_fire")):
		fire()
	
	
func fire():
	var bullet_in=bullet.instance()
	bullet_in.position = $Gun/Reticle.get_global_position()
	bullet_in.rotation_degrees= $Gun.rotation
	bullet_in.apply_impulse(Vector2(),Vector2(bulletspeed,0).rotated($Gun.rotation))
	get_tree().get_root().call_deferred("add_child",bullet_in)

func _on_hurtbox_area_entered(area):
	if area.is_in_group("Enemy") or area.is_in_group("EnemyBullet"):
		HP -= 1
		if HP <= 0:
			emit_signal("player_died")
		emit_signal("player_hurt", HP)

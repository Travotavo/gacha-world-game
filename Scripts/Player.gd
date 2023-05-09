extends KinematicBody2D
#set camera to center around player
#fix enemy movement

var movespeed=200
var bulletspeed=1000
var bullet=preload("res://Assets/Prefabs/Bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set("player", self)

func _physics_process(delta):
	var motion=Vector2()
	
	if Input.is_action_pressed("move_up"):
		motion.y-=1
	if Input.is_action_pressed("move_down"):
		motion.y+=1
	if Input.is_action_pressed("move_left"):
		motion.x-=1
	if Input.is_action_pressed("move_right"):
		motion.x+=1
	motion=motion.normalized()
	motion=move_and_slide(motion*movespeed)
	look_at(get_global_mouse_position())
	
	if(Input.is_action_just_pressed("action_fire")):
		fire()
	
	
func fire():
	var bullet_in=bullet.instance()
	bullet_in.position = $Gun.get_global_position()
	bullet_in.rotation_degrees= rotation_degrees
	bullet_in.apply_impulse(Vector2(),Vector2(bulletspeed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet_in)

	
	


func _on_Area2D_body_entered(body):
	pass

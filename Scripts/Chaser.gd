extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
var speed = 20
var awake = false

signal enemy_defeated
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if awake:
		velocity = Vector2.ZERO
		velocity = position.direction_to(Global.get("player").position) * speed
		velocity = move_and_slide(velocity)


func _on_HurtBox_area_entered(area):
	if area.is_in_group("Bullet"):
		emit_signal("enemy_defeated")
		queue_free()


func _on_WakeBox_area_entered(area):
	if area.is_in_group("Player"):
		awake = true

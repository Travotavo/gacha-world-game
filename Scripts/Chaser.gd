extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
export var hp = 10
export var hpMax = 10
export var speed = 20
export var awake = false

signal enemy_defeated
# Called when the node enters the scene tree for the first time.
func _ready():
	if awake:
		$Sprite.modulate = Color.white
		$WakeBox.queue_free()


func _physics_process(delta):
	if awake:
		velocity = Vector2.ZERO
		velocity = position.direction_to(Global.get("player").position) * speed
		velocity = move_and_slide(velocity)


func _on_HurtBox_area_entered(area):
	if area.is_in_group("Bullet") and awake:
		hp -= 1
		updateHP()
	if hp == 0:
		emit_signal("enemy_defeated")
		queue_free()

func updateHP():
	$ColorRect2/ColorRect.rect_size.x = lerp(0,40,(float(hp)/hpMax))

func _on_WakeBox_area_entered(area):
	if area.is_in_group("Player"):
		$Sprite.modulate = Color.white
		awake = true

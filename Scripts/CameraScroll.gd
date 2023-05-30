extends Camera2D

export var playerPath:NodePath
var Player:Node

export var lerpspeed = 4
 
func _ready():
	Player = get_node(playerPath)
	self.position = Player.position
func _physics_process(delta):
	if Player.position.x > self.position.x:
		self.position = lerp(self.position, Player.position, lerpspeed * delta)

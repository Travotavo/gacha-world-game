extends Camera2D

export var playerPath:NodePath
var Player:Node

export var lerpspeed = 4
 
func _ready():
	Player = get_node(playerPath)
	self.position = Player.position
func _physics_process(delta):
	self.position.x = lerp(self.position.x, Player.position.x, lerpspeed * delta)

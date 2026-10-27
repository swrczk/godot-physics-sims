extends Node2D


onready var obj = get_node("StaticBody2D")

var S = Vector2(300, 100)
var eqLength = 100
var k = 2
var pendulumForce = Vector2(0, 0)
var V = Vector2(0, 0)
var g = Vector2(0, 100)
var line = Line2D.new()

func _ready():
	obj.position = Vector2(400, 200)
	line.add_point(S)
	line.add_point(obj.position)
	line.width = 1
	self.add_child(line)
	
func _physics_process(delta):
	calcPenduluForce()
	V += delta * (pendulumForce + g)
	obj.position += delta * V
	line.points[1] = obj.position

func _draw():
	draw_circle(S, 5, Color.red)
	
func getDistance():
	return sqrt(pow(S.x - obj.position.x, 2) + pow(S.y - obj.position.y, 2))

func calcPenduluForce():
	var d = getDistance()
	var F = k * (eqLength -d)
	var Fx = (obj.position.x - S.x)/ d * F
	var Fy = (obj.position.y - S.y)/ d * F
	pendulumForce = Vector2(Fx, Fy)
	

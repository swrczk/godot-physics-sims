extends Node2D


var particle := load("res://point.tscn") as PackedScene
var step = 0
onready var rng = RandomNumberGenerator.new()
var deltaX

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
func _physics_process(delta):
	step += 1
	if step%5 == 0:
#		deltaX = rng.randf_range(-10, 10)
		generate(200, 200)
		step = 0


func generate( x: int, y: int ):
	var next_particle = particle.instance()
	next_particle.transform.origin = Vector2(x, y)
	add_child(next_particle)

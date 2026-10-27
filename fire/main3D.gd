extends Spatial


var particle := load("res://point3D.tscn") as PackedScene
var step = 0
var deltaX
var deltaZ
onready var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
func _physics_process(delta):
	step += 1
	if step%3 == 0:
		deltaX = rng.randf_range(-0.5, 0.5)
		deltaZ = rng.randf_range(-0.5, 0.5)
		generate(1 +deltaX, 1 , 1 +deltaZ)
		step = 0


func generate( x: int, y: int, z:int ):
	var next_particle = particle.instance()
	next_particle.transform.origin = Vector3(x, y, z)
	add_child(next_particle)

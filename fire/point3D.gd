extends Spatial


var Vx = 0
var Vy = 0.1
var Vz = 0
var delta = 0.01
var p_scale = 1.0
var G = 0.8
onready var cube = get_node("CSGBox")
var material

var Rx = 0
var Ry = 0
var Rz = 0
var rdelta = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	self.add_child(timer)
	timer.connect("timeout", self, "queue_free")
	timer.set_wait_time(2)
	timer.start()
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	Vx = rng.randf_range(-delta, delta)
	Vz = rng.randf_range(-delta, delta)
	
	Rx = rng.randf_range(-rdelta, rdelta)
	Ry = rng.randf_range(-rdelta, rdelta)
	Rz = rng.randf_range(-rdelta, rdelta)
	
	material = SpatialMaterial.new()
	material.albedo_color = Color(1.0, G, 0.0)
	cube.set_material(material)


func _physics_process(delta):
	self.transform.origin.x += Vx
	self.transform.origin.y += Vy
	self.transform.origin.z += Vz
	
	self.scale = Vector3(p_scale, p_scale, p_scale)
	if(p_scale) > 0.01:
		p_scale -= 0.01
		
	G -= 0.01
	material.albedo_color = Color(1.0, G, 0.0)
	cube.set_material(material)
	
	self.rotation_degrees.x += Rx
	self.rotation_degrees.y += Ry
	self.rotation_degrees.z += Rz

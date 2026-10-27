extends Node2D


var Vy = -1
var Vx = 0
var p_scale = 1.0
var G = 0.7


# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	self.add_child(timer)
	timer.connect("timeout", self, "queue_free")
	timer.set_wait_time(2)
	timer.start()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	Vx = rng.randf_range(-0.25, 0.25)
	self.modulate = Color(1.0, G, 0.0)


func _physics_process(delta):
	self.transform.origin.x += Vx
	self.transform.origin.y += Vy
	
	self.scale.x = p_scale
	self.scale.y = p_scale
	if(p_scale) > 0.01:
		p_scale -= 0.01
		
	G -= 0.01
	self.modulate = Color(1.0, G, 0.0)

extends Spatial




var S = Vector3(0, 20, 0)
var eqLength = 10
var k = 2
var pendulumForce = Vector3(0, 0, 0)
var V = Vector3(0, 0, 0)
var g = Vector3(0, -10, 0)
var obj = CSGSphere.new()
var static_obj = CSGSphere.new()
onready var line = get_node("ImmediateGeometry")

func _ready():
	obj.radius = 2
	obj.radial_segments = 20
	obj.rings = 10
	obj.transform.origin =Vector3(20,0,10)
	self.add_child(obj)
	
	static_obj.radius = 1
	static_obj.transform.origin = S
	self.add_child(static_obj)
	
func _physics_process(delta):
	calcPenduluForce()
	V += delta * (pendulumForce + g)
	obj.transform.origin += delta * V
	draw_Connection()

func draw_Connection():
	line.clear()
	line.begin(Mesh.PRIMITIVE_LINE_STRIP)
	line.add_vertex(obj.transform.origin)
	line.add_vertex(S)
	line.end()
	
func getDistance():
	return sqrt(pow(S.x - obj.transform.origin.x, 2) + pow(S.y - obj.transform.origin.y, 2) + pow(S.z - obj.transform.origin.z, 2))

func norma(X):
	return sqrt(pow(X.x, 2) + pow(X.y, 2) + pow(X.z, 2))
	
func calcPenduluForce():
	var d = eqLength - getDistance()
	var F = k * d
	var Fdir = obj.transform.origin - S
	var n = norma(Fdir)
	Fdir = Fdir / n
	pendulumForce = Fdir * F
	

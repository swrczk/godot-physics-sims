extends Spatial


var s1
var s2
var massZred
var e = 1
var sumOfR

func _ready():
	s1 = get_node("CSGSphere1")
	s2 = get_node("CSGSphere2")
	massZred = s1.mass * s2.mass / (s1.mass + s2.mass)
	sumOfR = s1.radius + s2.radius

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func norma(X):
	return sqrt(pow(X.x, 2) + pow(X.y, 2) + pow(X.z, 2))
	
func _physics_process(delta):
	s1.pos += s1.V * delta
	s2.pos += s2.V * delta
	
	var dist = s2.pos - s1.pos
	if(norma(dist) <= sumOfR):
		simulateBang(dist)
	else:
		s1.transform.origin = s1.pos
		s2.transform.origin = s2.pos
		
func simulateBang(dist):
	var n = dist / norma(dist)
	# rzut predkosci na normalna zderzenia (iloczyn skalarny)
	var V1perp = n * s1.V.dot(n)
	var V1parallel = s1.V - V1perp
	var V2perp = n * s2.V.dot(n)
	var V2parallel = s2.V - V2perp
	# predkosc zblizania sie kul wzdluz normalnej; <= 0 oznacza, ze juz sie oddalaja
	var deltaVperp = (V1perp - V2perp).dot(n)
	if deltaVperp <= 0:
		return
	var J = massZred * (e + 1) * deltaVperp
	s1.V = s1.V - J / s1.mass * n
	s2.V = s2.V + J / s2.mass * n

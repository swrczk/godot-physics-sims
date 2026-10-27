extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var predkosc = 3.0
var kierunek = Vector2(1.0, 2.0).normalized()

var sasiedzi = []

var predkoscMax = 3.0
var minSepar = 30
var wspSpojnosci = 0.025
var wspKierunku = 0.7
var wspSeparacji = 0.1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	self.rotation = Vector2(0, -1).angle_to(kierunek)
	var zderzenie = self.move_and_collide(predkosc * kierunek)
	if zderzenie:
		if zderzenie.collider is TileMap:
			kierunek = obslugaZderzenia(zderzenie)
		else:
			kierunek = zachowanieStadne()

func obslugaZderzenia(zderzenie):
	return (zderzenie.position - zderzenie.normal).direction_to(self.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body == self:
		return
	if body is KinematicBody2D:
		sasiedzi.push_back(body)


func _on_Area2D_body_exited(body):
	if body == self:
		return
	if body is KinematicBody2D:
		sasiedzi.erase(body)

func zachowanieStadne():
	var nowyKierunek = kierunek
	var spojnosc = Vector2(0,0)
	var separacja = Vector2(0,0)
	
	for sasiad in sasiedzi:
		nowyKierunek += sasiad.kierunek
		spojnosc += sasiad.position
		var odleglosc = self.position.distance_to(sasiad.position)
		if odleglosc < minSepar:
			separacja -= (sasiad.position - self.position).normalized() * (minSepar / odleglosc * predkosc)
			
	if sasiedzi.size() > 0:
		nowyKierunek = nowyKierunek / sasiedzi.size()
		spojnosc = spojnosc / sasiedzi.size()
		var doSrodka = self.position.direction_to(spojnosc)
		var aktPredkosc = predkoscMax * self.position.distance_to(spojnosc)
		spojnosc = doSrodka * aktPredkosc
	return (kierunek + nowyKierunek*wspKierunku + spojnosc*wspSpojnosci + separacja*wspSeparacji).clamped(predkoscMax)

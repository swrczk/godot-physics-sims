extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ppp := load("res://punkt.tscn") as PackedScene
var wcisnietyPPM := false
var przeciaganyWezel :punkt = null
var marginesSelekcji  = 20

var line2D: Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	tworzLine(Vector2(100,100), 20, 15)
	line2D = Line2D.new()
	line2D.default_color = Color.red
	add_child(line2D)
	update_line()
	
func _physics_process(delta):
	for child in get_children() :
		if child is Line2D :
			pass
		elif !child.isStatic:
			child.liczSile()
			
	for child in get_children():
		if child is Line2D :
			pass
		elif !child.isStatic:
			child.symplektEuler(delta)
	
	update_line()

func _input(event):
	if event is InputEventMouseButton:
		wcisnietyPPM = event.pressed
		przeciaganyWezel = null
		if wcisnietyPPM:
			for node in get_children():
				if event.position.distance_to(node.position) < marginesSelekcji:
					przeciaganyWezel = node
					break

func _process(_delta):
	if wcisnietyPPM:
		if przeciaganyWezel != null :
			przeciaganyWezel.position = get_global_mouse_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func tworzLine(poczatekLiny:Vector2, odstep:float, ileWezlow:int):
	var poprzedniPunkt:punkt
	for i in range(ileWezlow):
		var nowyPunkty := ppp.instance()
		nowyPunkty.position = Vector2(0, odstep * i) + poczatekLiny
		add_child(nowyPunkty)
		
		if i > 0 :
			nowyPunkty.dodajSasiada(poprzedniPunkt)
			poprzedniPunkt.dodajSasiada(nowyPunkty)
		else:
			nowyPunkty.isStatic = true
		poprzedniPunkt = nowyPunkty
		
func update_line():
	line2D.clear_points()
	for child in get_children():
		if child is Line2D :
			pass
		else:
			line2D.add_point(child.position)
	line2D.update()

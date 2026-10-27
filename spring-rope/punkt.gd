class_name punkt
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isStatic = false
var sasiedzi:Array = []
var odleglosciRownowagowe:Array = []

var predkosc := Vector2(0.0, 0.0)
var sila := Vector2(0.0, 0.0)
var grawitacja := Vector2(0.0, 300.0)
var sprezystosc :float = 500.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func dodajSasiada(pp):
	sasiedzi.append(pp)
	odleglosciRownowagowe.append((pp.position - position).length())
	
func liczSile():
	sila = Vector2()
	for i in range(sasiedzi.size()):
		var wektorRozsuniecia = sasiedzi[i].position - position
		var rozciagniecie = wektorRozsuniecia.length() - odleglosciRownowagowe[i]
		
		if rozciagniecie > 0:
			var kierunekRozsuniecia = wektorRozsuniecia.normalized()
			sila += sprezystosc * rozciagniecie * kierunekRozsuniecia
			
	sila += grawitacja 
	sila -= predkosc #tlumienie
	
func symplektEuler(delta):
	predkosc += sila * delta 
	position += predkosc * delta

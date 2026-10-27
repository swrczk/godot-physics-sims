extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const bb = preload("res://Boid.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	dodajWieleBoidow(80)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		dodajBoid(self.get_global_mouse_position())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func dodajBoid(newPosition:Vector2):
	var bo = bb.instance()
	add_child(bo)
	bo.global_position = newPosition
	bo.kierunek = Vector2( round(randf()) + 1, round(randf()) + 1)

func dodajWieleBoidow(ile):
	for i in range(ile):
		var x = rand_range(100, 800)
		var y = rand_range(100, 500)
		dodajBoid( Vector2(x, y) )

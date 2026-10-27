extends Node2D


var matrix = []
var matrixCP = []
var map:TileMap

var mapSizeX = 64
var mapSizeY = 36
var timeOut = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	matrixInit()
	map = get_node("TileMap")
	readMap()


func _physics_process(delta):
	timeOut = timeOut + 1
	if timeOut % 25 == 0:
		timeOut = 0
		updateMatrix()
		matrix = matrixCP.duplicate(true)
		setMap()
	else:
		return

func matrixInit():
	for i in range(mapSizeX):
		var temp1 = []
		var temp2 = []
		for j in range(mapSizeY):
			temp1.append(0)
			temp2.append(0)
		matrix.append(temp1)
		matrixCP.append(temp2)

func readMap():
	for i in range(mapSizeX):
		for j in range(mapSizeY):
			if map.get_cell(i, j) == 0: #kafelek jest zaznaczony
				matrix[i][j] = 1
			else:
				matrix[i][j] = 0

func setMap():
	for i in range(mapSizeX):
		for j in range(mapSizeY):
			if matrix[i][j] == 0:
				map.set_cell(i, j, 1)
			elif matrix[i][j] == 1:
				map.set_cell(i, j, 0)

func calcNeighbours(i, j):
	var sum = 0
	for x in range(-1, 2):
		var offsetX = x + i
		if offsetX < 0 or offsetX >= mapSizeX:
			continue
		for y in range(-1, 2):
			var offsetY = y + j
			if offsetY < 0 or offsetY >= mapSizeY:
				continue
			if offsetX == i and offsetY == j:
				continue
			if matrix[offsetX][offsetY] == 1:
				sum += 1
	return sum

func updateMatrix():
	for i in range(mapSizeX):
		for j in range(mapSizeY):
			var aliveCells = calcNeighbours(i, j)
			if (aliveCells == 2 or aliveCells == 3) and matrix[i][j] == 1:
				matrixCP[i][j] = 1
			else:
				matrixCP[i][j] = 0
			if aliveCells == 3  and matrix[i][j] == 0:
				matrixCP[i][j] = 1

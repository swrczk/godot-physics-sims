extends Node2D

var map:TileMap
var matrix = []
var mapSizeX = 128
var mapSizeY = 64
var random = RandomNumberGenerator.new()

func _ready():
	map = get_node("TileMap")
	for i in range(mapSizeX):
		var temp = []
		for j in range(mapSizeY):
			temp.append(2)
		matrix.append(temp)

func _physics_process(delta):
	updateMatrix()
	setMap()

func _input(event):
	var pos = (get_viewport().get_mouse_position() / 8).floor()
	var x = pos[0]
	var y = pos[1]
	
	if x < mapSizeX - 1 and x >= 0 and y < mapSizeY -1 and y >= 0:
		if Input.is_action_pressed("LMB"):
			map.set_cell(x, y, 0)
			matrix[x][y] = 0
		if Input.is_action_pressed("RMB"):
			map.set_cell(x, y, 1)
			matrix[x][y] = 1

func updateMatrix():
	for i in range(mapSizeX):
		for j in range(mapSizeY):
			if matrix[i][j] == 0:
				splywanie(i, j)
			if matrix[i][j] == 1:
				zsypywanie(i, j)

func splywanie(i, j):
	if j + 1 > mapSizeY - 1:
		return
	
	if matrix[i][j+1] == 0 and matrix[i][j-1] != 0:
		rozlewanie(i, j)	
		
	if matrix[i][j+1] == 2:
		matrix[i][j] = 2
		matrix[i][j+1] = 0
		
func zsypywanie(i, j):
	if j + 1 > mapSizeY - 1:
		return
		
	if matrix[i][j+1] == 1 and matrix[i][j-1] != 1:
		rozsypywanie(i, j)
		
	if matrix[i][j+1] != 1:
		var temp = matrix[i][j +1] 
		matrix[i][j+1] = 1
		matrix[i][j] = temp


func rozlewanie(i, j):
	var leftFree = -1
	var rightFree = -1
	var newI = i
	
	while(true):
		newI -= 1
		if newI < 0:
			break
		if matrix[newI][j + 1] == 2:
			leftFree = newI
			break
		if matrix[newI][j + 1] == 1:
			break
			
	newI = i
	
	while(true):
		newI += 1
		if newI > mapSizeX -1:
			break
		if matrix[newI][j + 1] == 2:
			rightFree = newI
			break
		if matrix[newI][j + 1] == 1:
			break
	
	if leftFree == -1 and rightFree != -1:
		matrix[i][j] = 2
		matrix[rightFree][j + 1] = 0
		
	if leftFree != -1 and rightFree == -1:
		matrix[i][j] = 2
		matrix[leftFree][j + 1] = 0
		
	if leftFree != -1 and rightFree != -1:
		matrix[i][j] = 2
		if random.randf() < 0.5:
			matrix[leftFree][j + 1] = 0
		else:
			matrix[rightFree][j + 1] = 0


func rozsypywanie(i, j):
	var leftFree = -1
	var rightFree = -1

	if i -1 >= 0 and i +1 < mapSizeX - 1:
		if matrix[i - 1][j + 1] == 2:
			leftFree = i - 1
		if matrix[i + 1][j + 1] == 2:
			rightFree = i + 1
	
	if leftFree == -1 and rightFree != -1:
		matrix[i][j] = 2
		matrix[rightFree][j + 1] = 1
		
	if leftFree != -1 and rightFree == -1:
		matrix[i][j] = 2
		matrix[leftFree][j + 1] = 1
		
	if leftFree != -1 and rightFree != -1:
		matrix[i][j] = 2
		if random.randf() < 0.5:
			matrix[leftFree][j + 1] = 1
		else:
			matrix[rightFree][j + 1] = 1


func setMap():
	for i in range(mapSizeX):
		for j in range(mapSizeY):
			map.set_cell(i, j, matrix[i][j])

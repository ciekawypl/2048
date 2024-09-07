extends Node2D

@export var tile_map : TileMap
@export var timer : Timer
var block_node = preload("res://Block/Block.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("up"):
		move(Vector2.UP)
	elif Input.is_action_just_pressed("down"):
		move(Vector2.DOWN)
	elif Input.is_action_just_pressed("left"):
		move(Vector2.LEFT)
	elif Input.is_action_just_pressed("right"):
		move(Vector2.RIGHT)


func move(direction : Vector2):
	if timer.is_stopped():
		timer.start()
		spawn_new_block()
		for block in get_tree().get_nodes_in_group("Block"):
			block.move(direction)


func spawn_new_block():
	var new_position : Vector2
	
	var busy = []
	for block in get_tree().get_nodes_in_group("Block"):
		busy.append(tile_map.local_to_map(block.global_position))
	
	while true:
		new_position = tile_map.map_to_local(Vector2i(randi_range(1, 4), randi_range(1, 4)))
		if busy.has(tile_map.local_to_map(new_position)):
			continue
		break
	
	var new_block = block_node.instantiate()
	new_block.global_position = new_position
	get_tree().root.add_child(new_block)

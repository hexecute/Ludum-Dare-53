extends Node2D

@export var map_scene: PackedScene

const open_tile_id = 3
const wall_tile_id = 4
const cell_size = 128

var player
var tile_map

# Called when the node enters the scene tree for the first time.
func _ready():
	tile_map = map_scene.instantiate()
	add_child(tile_map)
	player = tile_map.get_node('Player')
	set_player_position(Vector2i(0, 0))

func get_player_position():
	return Vector2i(floor(player.position.x/cell_size), floor(player.position.y/cell_size))

func set_player_position(coords: Vector2i):
	player.position.x = coords.x*cell_size + cell_size/2
	player.position.y = coords.y*cell_size + cell_size/2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var proposed_action = false
	var target: Vector2i
	
	if Input.is_action_just_pressed("move_left"):
		target = Vector2i(-1, 0)
		proposed_action = true
	elif Input.is_action_just_pressed("move_right"):
		target = Vector2i(1, 0)
		proposed_action = true
	elif Input.is_action_just_pressed("move_up"):
		target = Vector2i(0, -1)
		proposed_action = true
	elif Input.is_action_just_pressed("move_down"):
		target = Vector2i(0, 1)
		proposed_action = true
	
	if !proposed_action:
		return
	
	var dst = get_player_position() + target
	var dst_tile_id = tile_map.get_cell_source_id(0, dst)
	if dst_tile_id == wall_tile_id:
		return
	
	set_player_position(dst)

class_name Drone
extends Enemy

@export var behavior: Array[Vector2i]

var utils = preload("res://Utils.gd")

var i = 0

func automatic_action(map: Node, player_pos: Vector2i):
    var agent_pos = get_state()
    var dst = agent_pos + behavior[i % len(behavior)]
    var dst_tile_id = map.get_cell_source_id(0, dst)
    
    if utils.is_passable(dst_tile_id):
        set_state(dst)
        
    i += 1

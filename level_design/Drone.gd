class_name Drone
extends Enemy

@export var behavior: Array[Vector2i]

var utils = preload("res://level_design/Utils.gd")

var i = 0

func automatic_action(map: Node, player_pos: Vector2i):
    var agent_pos = get_state()
    if not len(behavior):
        return
    var vector = behavior[i % len(behavior)]
    var dst = agent_pos + vector
    var dst_tile_id = map.get_cell_source_id(0, dst)   
    
    if utils.is_passable(dst_tile_id):
        set_state(dst)
        
        if vector[0] > 0:
            get_node('Sprite2D').flip_h = false
            get_node('Sprite2D').rotation = 0
        elif vector[0] < 0:
            get_node('Sprite2D').flip_h = true
            get_node('Sprite2D').rotation = 0
        elif vector[1] > 0:
            get_node('Sprite2D').flip_h = false
            get_node('Sprite2D').rotation = PI / 2
        elif vector[1] < 0:
            get_node('Sprite2D').flip_h = false
            get_node('Sprite2D').rotation = - PI / 2
        
    i += 1

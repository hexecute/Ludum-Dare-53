class_name Chaser
extends Enemy

var utils = preload("res://level_design/Utils.gd")

func automatic_action(map: Node, player_pos: Vector2i):
    var agent_pos = get_state()
    var distance_diff = player_pos - agent_pos
    distance_diff = distance_diff.clamp(Vector2i(-1, -1), Vector2i(1, 1))
    
    # Do nothing if nothing needs to be done
    if not distance_diff.length():
        return

    var target: Vector2i
    var dst: Vector2i
    var dst_tile_id

    var will_move = false
    if distance_diff[0] != 0:
        target = Vector2i(distance_diff[0], 0)
        dst = get_state() + target
        
        dst_tile_id = map.get_cell_source_id(0, dst)
        if utils.is_passable(dst_tile_id):
            will_move = true
            
    if not will_move and distance_diff[1] != 0:
        target = Vector2i(0, distance_diff[1])
        dst = get_state() + target
        
        dst_tile_id = map.get_cell_source_id(0, dst)
        if utils.is_passable(dst_tile_id):
            will_move = true
            
    if will_move:
        set_state(dst)
    

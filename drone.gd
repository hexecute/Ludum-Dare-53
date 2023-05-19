class_name Drone
extends MapObject

var tile_map

func _ready():
    tile_map = get_parent()

func get_state():
    return get_coords()

func set_state(coords):
    set_coords(coords)

func can_lose():
    return get_coords() == tile_map.get_node('Player').get_coords()

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

    var blocked = true
    if distance_diff[0] != 0:
        target = Vector2i(distance_diff[0], 0)
        dst = get_state() + target
    elif blocked and distance_diff[1] != 0:
        target = Vector2i(0, distance_diff[1])
        dst = get_state() + target
    dst_tile_id = map.get_cell_source_id(0, dst)
    # HX: Use constants
    print(dst)
    if dst_tile_id != 4:
        set_state(dst)
    

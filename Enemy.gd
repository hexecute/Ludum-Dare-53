class_name Enemy
extends MapObject

var tile_map

@export var start_pos: Vector2i

func _ready():
    tile_map = get_parent()
    set_state(start_pos)

func get_state():
    return get_coords()

func set_state(coords):
    set_coords(coords)

func can_lose():
    return get_coords() == tile_map.get_node('Player').get_coords()

func automatic_action(map: Node, player_pos: Vector2i):
    pass

class_name Enemy
extends MapObject

var tile_map

func _ready():
    tile_map = get_parent()

func get_state():
    return get_coords()

func set_state(coords):
    set_coords(coords)
    for child in tile_map.get_children():
        if child is CustomButton:
            child.step(coords)

func can_lose():
    return get_coords() == tile_map.get_node('Player').get_coords()

func automatic_action(map: Node, player_pos: Vector2i):
    pass

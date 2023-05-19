class_name Player
extends MapObject

func get_state():
    return get_coords()

func set_state(coords):
    set_coords(coords)

func automatic_action(map: Node, player_pos: Vector2i):
    set_coords(player_pos)

func get_precedence():
    return 1

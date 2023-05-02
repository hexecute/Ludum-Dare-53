extends MapObject

@export var goal: Goal

# Whether the package is currently being carried by the player.
var is_carried = false

func get_state():
    return [is_carried, get_coords()]

func set_state(state):
    is_carried = state[0]
    set_coords(state[1])

func step(pos: Vector2i, interact: bool):
    if is_carried:
        set_coords(pos)
    if pos == get_coords() && interact:
        is_carried = !is_carried

func can_win():
    return get_coords() == goal.get_coords() && !is_carried

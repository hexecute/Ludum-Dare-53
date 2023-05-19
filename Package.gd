extends MapObject

@export var goal: Goal

# Whether the package is currently being carried by the player.
var is_carried = false

# Whether the package has been delivered to its goal.
var is_delivered = false

func get_state():
    return [is_carried, get_coords()]

func set_state(state):
    is_carried = state[0]
    set_coords(state[1])

func step(pos: Vector2i):
    if is_delivered:
        return
    if not is_carried && pos == get_coords():
        is_carried = true
    if is_carried:
        set_coords(pos)
        if get_coords() == goal.get_coords():
            is_carried = false
            is_delivered = true

func can_win():
    return is_delivered

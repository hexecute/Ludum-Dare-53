extends MapObject

@export var goal: Goal

# The unit currently carrying the package, or null if its not being carried.
var carried_by = null

# Whether the package has been delivered to its goal.
var is_delivered = false

func get_state():
    return [carried_by, get_coords()]

func set_state(state):
    carried_by = state[0]
    set_coords(state[1])

func automatic_action(map: Node, player_pos: Vector2i):
    if is_delivered:
        return
    if carried_by:
        set_coords(carried_by.get_coords())
        if get_coords() == goal.get_coords():
            carried_by = null
            is_delivered = true
        return
    
    # The package is not currently carried.
    # See if any unit picks up the package.
    for child in map.get_children():
        if !(child is MapObject):
            continue
        if child.get_coords() != get_coords():
            continue
        if child is Player or child is Enemy:
            carried_by = child

func can_win():
    return is_delivered

func get_precedence():
    return 2

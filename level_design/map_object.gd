class_name MapObject
extends Node2D

const cell_size = 128

# Returns whether this object prevents the player from moving to pos.
func can_move(pos: Vector2i):
    return true
    
# Returns true unless this object has an unsatisfied win condition.
func can_win():
    return true
    
# Returns false unless this object has an unsatisfied loss condition.
func can_lose():
    return false

# Updates the state of this object and any objects it impacts,
# given player movement to pos.
func step(pos: Vector2i):
    pass
    
# Update the state of this object (for automated objects)
func automatic_action(map: Node, player_pos: Vector2i):
    pass

# Returns the state of this object.
func get_state():
    return null

# Restores a previous state of this object.
func set_state(state):
    pass

func get_coords():
    return Vector2i(floor(position.x/cell_size), floor(position.y/cell_size))

func set_coords(coords: Vector2i):
    position.x = coords.x*cell_size + cell_size/2
    position.y = coords.y*cell_size + cell_size/2

# Precedence controlling order that objects are updated.
func get_precedence():
    return 0

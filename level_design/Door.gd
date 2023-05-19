class_name Door
extends MapObject

var new_texture = preload("res://assets/open_door.png")

var unlocked = false

# Called from a Button or other object that opens this door.
func unlock():
    unlocked = true
    get_node('Sprite2D').set_texture(new_texture)

# We store whether we're unlocked in the state in case player undos.
func get_state():
    return unlocked

func set_state(state):
    unlocked = state

func can_move(pos):
    return unlocked or pos != get_coords()

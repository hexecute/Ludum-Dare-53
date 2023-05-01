class_name Door
extends MapObject

var unlocked = false

func unlock():
	unlocked = true

func step(pos):
	return unlocked

func restore(state):
	unlocked = state

func can_move(pos):
	return unlocked or pos != get_coords()

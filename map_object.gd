class_name MapObject
extends Node2D

const cell_size = 128

func can_move(pos: Vector2i):
	return true

# Returns the state of this object after the player moves to pos.
func step(pos: Vector2i):
	return null

# Restores a previous state of this object.
func restore(state):
	pass

func get_coords():
	return Vector2i(floor(position.x/cell_size), floor(position.y/cell_size))

func set_coords(coords: Vector2i):
	position.x = coords.x*cell_size + cell_size/2
	position.y = coords.y*cell_size + cell_size/2

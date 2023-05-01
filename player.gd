extends MapObject

func step(pos: Vector2i):
	return get_coords()

func restore(coords):
	set_coords(coords)

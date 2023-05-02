extends MapObject

@export var target: Door

func step(pos):
    if pos == get_coords():
        target.unlock()

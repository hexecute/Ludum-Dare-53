extends MapObject

@export var target: Door

func step(pos: Vector2i, interact: bool):
    if pos == get_coords():
        target.unlock()

class_name CustomButton
extends MapObject

@export var target: Door

func step(pos: Vector2i):
    if pos == get_coords():
        target.unlock()

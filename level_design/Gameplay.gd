extends Node2D

@export var allow_pause : bool = true

var utils = preload("res://level_design/Utils.gd")

var player
var tile_map
var stack = []

# Called when the node enters the scene tree for the first time.
func _ready():
    tile_map = self
    add_child(tile_map)
    player = tile_map.get_node('Player')

func get_map_objects():
    var l = []
    for child in tile_map.get_children():
        if !(child is MapObject):
            continue
        l.push_back(child)
    l.sort_custom(func(a, b): return a.get_precedence() < b.get_precedence())
    return l

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if Input.is_action_just_pressed("undo"):
        if len(stack) == 0:
            print("can't undo, stack is already empty")
            return
        var states = stack[-1]
        stack.pop_back()
        for node_path in states:
            get_node(node_path).set_state(states[node_path])
        return
    
    var proposed_action = false
    var target = Vector2i(0, 0)
    
    if Input.is_action_just_pressed("move_left"):
        target = Vector2i(-1, 0)
        player.get_node('Sprite2D').flip_h = true
        proposed_action = true
    elif Input.is_action_just_pressed("move_right"):
        target = Vector2i(1, 0)
        player.get_node('Sprite2D').flip_h = false
        proposed_action = true
    elif Input.is_action_just_pressed("move_up"):
        target = Vector2i(0, -1)
        proposed_action = true
    elif Input.is_action_just_pressed("move_down"):
        target = Vector2i(0, 1)
        proposed_action = true
    elif Input.is_action_just_pressed("pause"):
        proposed_action = allow_pause
    elif Input.is_action_just_pressed("ui_cancel"):
        get_node("LevelControl").show()
        get_tree().paused = true
    
    if !proposed_action:
        return
    
    var current = player.get_coords()
    var dst = current + target
    var dst_tile_id = tile_map.get_cell_source_id(0, dst)
    if not utils.is_passable(dst_tile_id):
        return
    
    # See if any children want to prevent the movement.
    for child in get_map_objects():
        if !child.can_move(dst):
            print("child ", child, " prevents movement to ", dst)
            return
    
    print("player moves to ", dst)
    
    # Collect and save pre-change states.
    var states = {}
    for child in get_map_objects():
        var state = child.get_state()
        states[child.get_path()] = state
    stack.push_back(states)
    
    # Update children.
    for child in get_map_objects():
        child.step(dst)

    # Update automated children
    for child in get_map_objects():
        child.automatic_action(tile_map, dst)
    
    # Update world
    if dst_tile_id == utils.CRACKED:
        tile_map.set_cell(0, dst, -1)
    
    # Check win condition.
    var can_win = true
    var can_lose = false
    for child in get_map_objects():
        can_lose = can_lose || child.can_lose()
        can_win = can_win && child.can_win()
    if can_lose:
        print("YOU LOSE!")
    elif can_win:
        print("YOU WIN!")

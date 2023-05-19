extends Node2D

@export var map_scene: PackedScene

const open_tile_id = 3
const wall_tile_id = 4

var player
var tile_map
var stack = []

# Called when the node enters the scene tree for the first time.
func _ready():
    tile_map = map_scene.instantiate()
    add_child(tile_map)
    player = tile_map.get_node('Player')
    player.set_coords(Vector2i(0, 0))

func get_map_objects():
    var l = []
    for child in tile_map.get_children():
        if !(child is MapObject):
            continue
        l.push_back(child)
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
    var interact = false
    
    if Input.is_action_just_pressed("move_left"):
        target = Vector2i(-1, 0)
        proposed_action = true
    elif Input.is_action_just_pressed("move_right"):
        target = Vector2i(1, 0)
        proposed_action = true
    elif Input.is_action_just_pressed("move_up"):
        target = Vector2i(0, -1)
        proposed_action = true
    elif Input.is_action_just_pressed("move_down"):
        target = Vector2i(0, 1)
        proposed_action = true
    elif Input.is_action_just_pressed("pause"):
        proposed_action = true
    elif Input.is_action_just_pressed("interact"):
        interact = true
        proposed_action = true
    
    if !proposed_action:
        return
    
    var current = player.get_coords()
    var dst = current + target
    var dst_tile_id = tile_map.get_cell_source_id(0, dst)
    if dst_tile_id == wall_tile_id:
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
    
    # Update interactable children
    for child in get_map_objects():
        child.step(dst, interact)

    # Update automated children
    for child in get_map_objects():
        child.automatic_action(tile_map, dst)
        
    player.set_coords(dst)    
    
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

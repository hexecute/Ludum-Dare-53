extends TileMap

var open_tile_id = 3
var wall_tile_id = 4

var cell_size = 128

var player
var agent

# Called when the node enters the scene tree for the first time.
func _ready():
    player = get_node('Player')
    agent = get_node('HunterAgent')
    set_node_position(player, Vector2i(0, 0))
    set_node_position(agent, Vector2i(-6, -6))

func get_node_position(node):
    return Vector2i(floor(node.position.x/cell_size), floor(node.position.y/cell_size))

func set_node_position(node, coords: Vector2i):
    node.position.x = coords.x*cell_size + cell_size/2
    node.position.y = coords.y*cell_size + cell_size/2

func handle_player_movement():
    """
    Return: (Boolean) Did player attempt an action?
    """
    var target: Vector2i

    if Input.is_action_just_released("move_left"):
        target = Vector2i(-1, 0)
    elif Input.is_action_just_released("move_right"):
        target = Vector2i(1, 0)
    elif Input.is_action_just_released("move_up"):
        target = Vector2i(0, -1)
    elif Input.is_action_just_released("move_down"):
        target = Vector2i(0, 1)
    else:
        return false

    var dst = get_node_position(player) + target
    var dst_tile_id = get_cell_source_id(0, dst)
    if dst_tile_id != wall_tile_id:
        set_node_position(player, dst)
    return true

func handle_agent_movement():
    var player_position = get_node_position(player)
    var agent_position = get_node_position(agent)
    var distance_diff = player_position - agent_position
    distance_diff = distance_diff.clamp(Vector2i(-1, -1), Vector2i(1, 1))

    var target: Vector2i
    var dst: Vector2i
    var dst_tile_id

    var blocked = true
    if distance_diff[0] != 0:
        target = Vector2i(distance_diff[0], 0)
        dst = get_node_position(agent) + target
        dst_tile_id = get_cell_source_id(0, dst)
        if dst_tile_id != wall_tile_id:
            set_node_position(agent, dst)
            blocked = false
    if blocked and distance_diff[1] != 0:
        target = Vector2i(0, distance_diff[1])
        dst = get_node_position(agent) + target
        dst_tile_id = get_cell_source_id(0, dst)
        if dst_tile_id != wall_tile_id:
            set_node_position(agent, dst)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if handle_player_movement():
        handle_agent_movement()

func _on_player_area_entered(area):
    print('GAME OVER!')

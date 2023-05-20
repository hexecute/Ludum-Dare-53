extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func _on_main_menu_button_pressed():
    get_tree().change_scene_to_file("res://menu.tscn")


func _on_level_0_button_pressed():
    get_tree().change_scene_to_file("res://levels/map_0.tscn")


func _on_level_1_button_pressed():
    get_tree().change_scene_to_file("res://levels/map_1.tscn")


func _on_level_2_button_pressed():
    get_tree().change_scene_to_file("res://levels/map_2.tscn")


func _on_level_3_button_pressed():
    get_tree().change_scene_to_file("res://levels/map_3.tscn")


func _on_level_4_button_pressed():
    get_tree().change_scene_to_file("res://levels/map_4.tscn")

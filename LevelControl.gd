extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
    self.hide()


func _on_restart_pressed():
    get_tree().paused = false
    get_tree().change_scene_to_file("res://level_select.tscn")


func _on_level_select_button_pressed():
    get_tree().paused = false
    get_tree().change_scene_to_file("res://level_select.tscn")


func _on_resume_button_pressed():
    get_tree().paused = false
    self.hide()

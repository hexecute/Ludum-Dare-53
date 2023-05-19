extends Control

@export var pausing : bool = true
@export var win : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
    self.hide()
    
func show_ui():
    get_node("PanelContainer/CenterContainer/VBoxContainer/ResumeButton").visible = pausing
    var win_lose_label = get_node("PanelContainer/CenterContainer/VBoxContainer/WinLoseLabel")
    win_lose_label.visible = !pausing
    if win:
        win_lose_label.text = 'YOU WIN'
    else:
        win_lose_label.text = 'YOU LOSE'
    
    self.show()

func _on_restart_pressed():
    get_tree().paused = false
    get_tree().change_scene_to_file(get_tree().current_scene.scene_file_path)


func _on_level_select_button_pressed():
    get_tree().paused = false
    get_tree().change_scene_to_file("res://level_select.tscn")


func _on_resume_button_pressed():
    get_tree().paused = false
    self.hide()

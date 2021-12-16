extends CanvasLayer

signal start_game

func _ready():
	$VBoxContainer/Start.grab_focus()

func _on_Quit_button_down():
	get_tree().quit()


func _on_Start_button_down():
	emit_signal('start_game')

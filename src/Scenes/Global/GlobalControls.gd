extends Control

func _input(event):
	if event.is_action_pressed('ui_fullscreen'):
		toggle_fullscreen()

func toggle_fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen

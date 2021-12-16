extends CanvasLayer

onready var LevelDisplay = $VBoxContainer/PanelContainer/HBoxContainer/LevelDisplay
onready var MoveDisplay = $VBoxContainer/PanelContainer/HBoxContainer/MoveDisplay
onready var PushDisplay = $VBoxContainer/PanelContainer/HBoxContainer/PushDisplay
onready var TimerDisplay = $VBoxContainer/PanelContainer/HBoxContainer/TimerDisplay


func update_level(n):
	LevelDisplay.update_value(str(n))

func update_move(n):
	MoveDisplay.update_value(str(n))

func update_push(n):
	PushDisplay.update_value(str(n))

func update_timer(n):
	var s = n % 60
	var m = (n / 60) % 60
	var h = (n /(60*60)) % 60
	TimerDisplay.update_value("%02d:%02d:%02d" % [h, m, s])

func _on_Ticker_tick(n):
	update_timer(n)


func _on_Level_stats_change(moves, pushes):
	update_move(moves)
	update_push(pushes)


func _on_Level_level_change(n):
	update_level(n)

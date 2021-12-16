extends Node

onready var main_menu = preload("res://src/Scenes/Main Menu/Main Menu.tscn")
onready var level = preload('res://src/Scenes/Level/Level.tscn')

var current_scene = null

var current_map_set = 'original'
var current_map_id = 0


func _ready():
	main_menu()

func main_menu():
	if current_scene:
		current_scene.queue_free()
	current_scene = main_menu.instance()
	current_scene.connect('start_game', self, '_on_Main_Menu_start_game')
	add_child(current_scene)

func load_level():
	if current_scene:
		current_scene.queue_free()
	var map = $LevelImporter.get_map(current_map_set, current_map_id)
	if !map:
		current_map_id = 0
		map = $LevelImporter.get_map(current_map_set, current_map_id)
	
	current_scene = level.instance()
	current_scene.connect('level_complete', self, "_on_Level_level_complete")
	add_child(current_scene)
	current_scene.set_level(map, current_map_id + 1)

func _on_Main_Menu_start_game():
	current_map_id = 0
	load_level()

func _on_Level_level_complete():
	current_map_id += 1
	load_level()

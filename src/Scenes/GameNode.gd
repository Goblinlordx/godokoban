extends Node

func _ready():
	call_deferred('load_level')

var current_map_set = 'original'
var current_map_id = 0

func load_level():
	var map = $LevelImporter.get_map(current_map_set, current_map_id)
	if !map:
		current_map_id = 0
		map = $LevelImporter.get_map(current_map_set, current_map_id)
	$Level.set_level(map)
		

func _on_Level_level_complete():
	current_map_id += 1
	load_level()

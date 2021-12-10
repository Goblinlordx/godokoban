extends Node2D

export (PackedScene) var wall
export (PackedScene) var player
export (PackedScene) var box
export (PackedScene) var goal

signal level_complete

var level_complete = false
var current_level = null

var goals = []
var players = []

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("level_reset"):
		set_level(current_level)
		

func set_level(level_data):
	level_complete = false
	current_level = level_data
	var pieces = get_tree().get_nodes_in_group('level_piece')
	for p in pieces:
		p.get_parent().remove_child(p)
	
	build_instances(level_data.wall, wall)
	goals = build_instances(level_data.goal, goal)
	build_instances(level_data.box, box)
	players = build_instances(level_data.player, player)
	for p in players:
		p.connect('check_goals', self, '_on_Player_check_goals')

func build_instances(coords, scene):
	var instances = []
	for coord in coords:
		var inst = scene.instance()
		inst.position = $Tiles.map_to_world(coord)
		get_parent().add_child(inst)
		instances.push_back(inst)
	return instances

func check_goals():
	for g in goals:
		if !g.occupied:
			return
	level_complete = true
	for p in players:
		p.disabled = true
	emit_signal('level_complete')

func _on_Player_check_goals():
	if !level_complete:
		check_goals()

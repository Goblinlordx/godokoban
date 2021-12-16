extends Node2D

export (PackedScene) var wall
export (PackedScene) var player
export (PackedScene) var box
export (PackedScene) var goal

signal level_complete
signal tick(n)
signal level_change(n)
signal stats_change(moves, pushes)

var level_complete = false
var current_level_num = 0
var current_level = null
var moves = 0
var pushes = 0

var goals = []
var players = []

func _input(event):
	if level_complete:
		return
	if event.is_action_pressed("level_reset"):
		set_level(current_level)
		enable_players()
		

func set_level(level_data, level_number = current_level_num):
	level_complete = false
	current_level = level_data
	$GUI.update_level(level_number)
	$GUI.update_move(0)
	$GUI.update_push(0)
	$GUI.update_timer(0)
	var pieces = get_tree().get_nodes_in_group('level_piece')
	for p in pieces:
		remove_child(p)
	
	pieces = []
	pieces.append_array(build_instances(level_data.wall, wall))
	goals = build_instances(level_data.goal, goal)
	pieces.append_array(goals)
	pieces.append_array(build_instances(level_data.box, box))
	players = build_instances(level_data.player, player)
	pieces.append_array(players)
	var bottom_right = Vector2(0, 0)
	for p in pieces:
		if p.position.x > bottom_right.x:
			bottom_right.x = p.position.x
		if p.position.y > bottom_right.y:
			bottom_right.y = p.position.y
	
	for p in players:
		p.set_camera(Vector2(bottom_right.x/2, bottom_right.y/2))
		p.connect('check_goals', self, '_on_Player_check_goals')
		p.connect('move', self, '_on_Player_move')
	disable_players()
	moves = 0
	pushes = 0
	$Ticker.reset()
	emit_signal('stats_change', moves, pushes)
	$Transition.transition(Transition.TYPE.CURTAIN_OUT)
	yield($Transition, "transition_complete")
	enable_players()

func build_instances(coords, scene):
	var instances = []
	for coord in coords:
		var inst = scene.instance()
		inst.position = $Tiles.map_to_world(coord)
		add_child(inst)
		instances.push_back(inst)
	return instances

func check_goals():
	for g in goals:
		if !g.occupied:
			return
	level_complete = true
	for p in players:
		p.disabled = true
	$Ticker.stop()
	level_complete = true
	$Transition.transition(Transition.TYPE.CURTAIN_IN)
	yield($Transition, "transition_complete")
	emit_signal('level_complete')

func disable_players():
	$Ticker.stop()
	for p in players:
		p.set_process_input(false)

func enable_players():
	$Ticker.start()
	for p in players:
		p.set_process_input(true)

func _on_Player_check_goals():
	if !level_complete:
		check_goals()

func _on_Player_move(push):
	moves += 1
	if push:
		pushes += 1
	emit_signal('stats_change', moves, pushes)


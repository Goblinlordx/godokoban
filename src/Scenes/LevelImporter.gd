extends Node

const PLAYER = 'player'
const BOX = 'box'
const WALL = 'wall'
const GOAL = 'goal'

const CHARS = {
	'@': [PLAYER],
	'p': [PLAYER],
	'+': [PLAYER, GOAL],
	'P': [PLAYER, GOAL],
	'$': [BOX],
	'b': [BOX],
	'B': [BOX, GOAL],
	'*': [BOX, GOAL],
	'#': [WALL],
	'.': [GOAL],
	'-': [],
	'_': [],
	' ': [],	
}

var lvl_map = {
	'original': []
}

func parse_level(lines):
	var level = {
		WALL: [],
		PLAYER: [],
		BOX: [],
		GOAL: [],
	}
	var y = 0
	for line in lines:
		var chars = line.split('', false)
		var x = 0
		for c in line:
			var items = CHARS[c]
			for item in items:
				level[item].push_back(Vector2(x, y))
			x += 1
		y += 1
	return level
	

func load_file(fp):
	var file = File.new()
	file.open(fp, File.READ)
	var text = file.get_as_text()
	file.close()
	var lines = text.split('\n', true)
	var level_lines = []
	var levels = []
	for line in lines:
		if line.empty() or line[0] == ';':
			if level_lines.size() != 0:
				levels.push_back(parse_level(level_lines))
				level_lines = []
			continue
		level_lines.push_back(line)
	
	if level_lines.size() != 0:
		levels.push_back(parse_level(level_lines))
	
	lvl_map.original = levels


func _ready():
	load_file('res://src/Data/basic_levels.sok')

func get_map(map_set, id):
	var set = lvl_map[map_set]
	if !set:
		return null
	var map = set[id]
	if !map:
		return null
	return map

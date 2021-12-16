extends CenterContainer

export (String) var label : String
export (String) var value : String


func _ready():
	_update()

func update_label(s: String):
	label = s
	_update()

func update_value(s: String):
	value = s
	_update()

func _update():
	$Label.text = "%s: %s" % [label, value]
	

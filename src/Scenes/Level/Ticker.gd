extends Node

signal tick(n)

var start = 0
var d = 0

func reset():
	d = 0
	emit_signal('tick', d)

func start():
	start = OS.get_system_time_secs()
	emit_signal('tick', d)
	set_process(true)

func stop():
	set_process(false)
	return d

func _process(x):
	var delta = OS.get_system_time_secs() - start - d
	if delta > 0:
		d += delta
		emit_signal('tick', d)

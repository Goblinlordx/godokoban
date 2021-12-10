extends KinematicBody2D

export var grid_size = 16
onready var ray = $RayCast2D
signal check_goals

var disabled = false
var animating = false

var inputs = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}

func _input(event):
	if disabled:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(inputs[dir])

func move(vec):
	set_process_input(false)
	var next_vec = vec * grid_size
	ray.cast_to = next_vec
	ray.force_raycast_update()
	var anim = false
	
	if !ray.is_colliding():
		anim = true
	else:
		var obj = ray.get_collider()
		if obj.is_in_group('movable'):
			if obj.move(next_vec):
				anim = true
	
	if anim:
		$Tween.interpolate_property(
			self,
			'position',
			position,
			position + next_vec,
			.1,
			Tween.TRANS_SINE
		)
		$Tween.start()
		yield($Tween, 'tween_all_completed')
		emit_signal('check_goals')
	
	set_process_input(true)

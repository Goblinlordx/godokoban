extends KinematicBody2D

export var grid_size = 16
onready var ray = $RayCast2D

func move(next_vec):
	ray.cast_to = next_vec
	ray.force_raycast_update()
	$Tween.interpolate_property(
		self,
		'position',
		position,
		position + next_vec,
		.1,
		Tween.TRANS_SINE
	)
	if !ray.is_colliding():
		$Tween.start()
		return true
	return false

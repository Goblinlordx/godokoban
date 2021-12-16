extends CanvasLayer

class_name Transition

onready var tween: = $ColorRect/Tween

signal transition_complete

var cutoff = 1 setget _set_cutoff, _get_cutoff

enum TYPE {CURTAIN_IN, CURTAIN_OUT}


func transition(type, time = 1.5):
	match type:
		TYPE.CURTAIN_IN:
			tween.interpolate_property(
				self,
				'cutoff',
				1,
				0,
				time,
				Tween.TRANS_SINE,
				Tween.EASE_OUT
			)
		TYPE.CURTAIN_OUT:
			tween.interpolate_property(
				self,
				'cutoff',
				0,
				1,
				time,
				Tween.TRANS_SINE,
				Tween.EASE_OUT
			)
	tween.start()
	yield(tween, "tween_all_completed")
	emit_signal('transition_complete')

func _set_cutoff(n: float):
	$ColorRect.material.set_shader_param('cutoff', n)

func _get_cutoff():
	$ColorRect.material.get_shader_param('cutoff')

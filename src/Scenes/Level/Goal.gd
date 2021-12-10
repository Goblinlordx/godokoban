extends Area2D

var occupied = false

func _on_Area2D_body_entered(body):
	if body.is_in_group('movable'):
		occupied = true


func _on_Area2D_body_exited(body):
	if body.is_in_group('movable'):
		occupied = false

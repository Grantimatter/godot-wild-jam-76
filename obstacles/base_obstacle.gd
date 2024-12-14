class_name Obstacle extends Node3D

func _on_activation_body_entered(body: Node3D) -> void:
	print("Obstacle Activated!")
	SignalBus.obstacle_activated.emit(global_position)
	#activated.emit(global_position)
	$Sound.play()

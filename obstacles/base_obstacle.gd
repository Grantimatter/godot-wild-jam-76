class_name Obstacle extends Node3D

func _on_activation_body_entered(body: Node3D) -> void:
	SignalBus.obstacle_activated.emit(global_position) 
	$Sound.play()

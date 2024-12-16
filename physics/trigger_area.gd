class_name TriggerArea extends Area3D
signal triggered(body: Node3D)

func _on_body_entered(body: Node3D) -> void:
	trigger(body)

func trigger(body: Node3D) -> void:
	triggered.emit(body)

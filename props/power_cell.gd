class_name PowerCell extends MeshInstance3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	_collect_power_cell()

func _collect_power_cell() -> void:
	print("Power cell collected")
	SignalBus.power_cell_collected.emit()
	queue_free()

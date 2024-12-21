class_name PowerCell extends MeshInstance3D

var collected: bool = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if not collected:
		_collect_power_cell()

func _collect_power_cell() -> void:
	collected = true
	hide()
	SignalBus.power_cell_collected.emit()
	$AudioStreamPlayer3D.play()

func _on_audio_stream_player_3d_finished() -> void:
	if collected:
		queue_free()

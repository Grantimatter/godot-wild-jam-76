extends Node

@export_group("Menu/Continue")
@export var default_scene: PackedScene

func _on_exit_triggered(body: Node3D) -> void:
	get_tree().root.queue_free()

func _on_continue_triggered(body: Node3D) -> void:
	call_deferred("continue_game")

func continue_game():
	get_tree().change_scene_to_packed(_get_next_level())

func _get_next_level() -> PackedScene:
	return default_scene

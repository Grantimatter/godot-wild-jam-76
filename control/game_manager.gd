extends Node

@export var main_level: PackedScene

var is_player_alive: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.player_killed.connect(_on_player_killed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		print("Canceled...")
		get_tree().change_scene_to_packed(main_level)
	if not is_player_alive:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().reload_current_scene()
			is_player_alive = true

func _on_player_killed() -> void:
	is_player_alive = false

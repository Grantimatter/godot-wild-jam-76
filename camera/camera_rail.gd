class_name CameraRail extends Path3D

@export var follow_target: Node3D
@export var camera_position_rail: Path3D
@export var camera_look_rail: Path3D

@onready var naviagation_agent = $NavigationAgent3D

func _physics_process(delta: float) -> void:
	#naviagation_agent.set_target_position(follow_target.global_position)
	var closest_point = camera_position_rail.curve.get_closest_point(follow_target.global_position)

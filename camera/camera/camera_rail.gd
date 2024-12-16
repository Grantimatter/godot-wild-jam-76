class_name CameraRail extends Path3D

@export var follow_target: Node3D

@onready var naviagation_agent = $NavigationAgent3D

func _physics_process(delta: float) -> void:
	#naviagation_agent.set_target_position(follow_target.global_position)
	pass

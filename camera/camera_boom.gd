class_name CameraBoom extends Node3D

@export var follow_speed: float = 3
@export var aim_speed: float = 1

@onready var camera = $Camera3D

func _physics_process(delta: float) -> void:
	camera.global_position = camera.global_position.lerp($CameraBoom/HorizontalSpringArm/CameraTargetPos.global_position, delta * follow_speed)
	var look_direction = (camera.transform as Transform3D).looking_at(global_position)
	camera.quaternion = (camera.quaternion as Quaternion).slerp(look_direction.basis, delta * aim_speed)

func _process(delta: float) -> void:
	pass
	

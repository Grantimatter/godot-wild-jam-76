class_name PatrolPath extends Path3D

@onready var follow_path = $PathFollow3D

#func _ready() -> void:
	#if curve.get_point_position(0) == curve.get_point_position(curve.point_count - 1):
		#follow_path.loop = true
		#print("Curve is looping!")
	#else:
		#follow_path.loop = false
		#print("Curve is not looping!")

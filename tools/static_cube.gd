@tool
class_name static_cube extends StaticBody3D

@export var dimensions: Vector3 = Vector3(1,1,1)

@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var mesh: MeshInstance3D = $MeshInstance3D

func _enter_tree() -> void:
	call_deferred("_init_cube")

func _init_cube() -> void:
	collision_shape.shape = BoxShape3D.new()
	mesh.mesh = BoxMesh.new()
	resize()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		resize()

func _validate_property(property: Dictionary) -> void:
	if Engine.is_editor_hint():
		if property.name == "dimensions":
			resize()

func resize() -> void:
	if collision_shape.shape == null or mesh.mesh == null:
		return
	if scale != Vector3(1,1,1):
		dimensions += (scale - Vector3(1,1,1)) * .1
		dimensions = dimensions.clamp(Vector3(.1, .1, .1), Vector3(2000, 2000, 2000))
		scale = Vector3(1,1,1)
	collision_shape.shape.size = dimensions
	mesh.mesh.size = dimensions

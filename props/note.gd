@tool
class_name Note extends Interactable

@export var mesh: Mesh
@export var background: Texture2D
@export_multiline var text: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	$Control/ColorRect/Label.text = text
	$Control.hide()
	#$MeshInstance3D.mesh = mesh

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_interact() -> void:
	super()

func do_interact():
	if is_interacting:
		end_interact()
		return
	super()
	if $Control/ColorRect/Label.text.length() > 0:
		_hide_tooltip()
		$Control.show()

func end_interact() -> void:
	super()
	$Control.hide()

func stop_interact() -> void:
	super()
	$Control.hide()

func _validate_property(property: Dictionary) -> void:
	pass
	#if property.name == "mesh":
		#$MeshInstance3D.mesh = mesh

class_name Player extends BaseCharacter
signal died(killer: Enemy)

@export_group("Player/Movement")
@export var speed: float = 5.0

@onready var camera = $CameraBoom/Camera3D

var is_alive: bool = true
var interactable_array: Array[Interactable] = []
var current_interactable: Interactable:
	get:
		if interactable_array.size() > 0:
			return interactable_array[0]
		return null

func _ready() -> void:
	call_deferred("_setup_camera")

func _input(event):
	if event.is_action_pressed("interact"):
		interact(current_interactable)

func _setup_camera() -> void:
	camera.reparent(get_parent())

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	_select_interactable()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func _on_enemy_detector_body_entered(body: Node3D) -> void:
	die(body as Enemy)

func _on_interaction_area_area_entered(area: Area3D) -> void:
	if not interactable_array.has(area as Interactable):
		interactable_array.append(area as Interactable)

func _select_interactable():
	if interactable_array.size() > 1:
		interactable_array.sort_custom(_sort_interactables)
		for i: Interactable in interactable_array.slice(1):
			i.stop_interact()

	if interactable_array.size() > 0:
		interactable_array[0].start_interact()

func _on_interaction_area_area_exited(area: Area3D) -> void:
	var interactable: Interactable = area as Interactable
	if interactable_array.has(interactable):
		interactable.stop_interact()
		interactable_array.erase(interactable)

func _sort_interactables(a: Interactable, b: Interactable):
	return global_position.distance_to(a.global_position) < global_position.distance_to(b.global_position)

func interact(interactable: Interactable):
	if interactable == null:
		return
	interactable.do_interact()

func _stop_interact(interactable: Interactable):
	if interactable == null:
		return
	
	interactable.stop_interact()

func die(enemy: Enemy) -> void:
	SignalBus.player_killed.emit()
	died.emit()
	$CameraBoom.reparent(get_parent())
	queue_free()

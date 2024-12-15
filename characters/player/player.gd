class_name Player extends BaseCharacter
signal died(killer: Enemy)

@export_group("Player/Movement")
@export var speed: float = 5.0

var is_alive: bool = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

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

func die(enemy: Enemy) -> void:
	SignalBus.player_killed.emit()
	died.emit()
	queue_free()

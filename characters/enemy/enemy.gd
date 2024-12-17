class_name Enemy extends BaseCharacter
signal alert_start
signal alert_end
signal sus_start
signal sus_end

@export var patrol_speed: float = 5
@export var alerted_speed: float = 15
@export var sus_time: float = 5
@export var patrol_path: PatrolPath

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var starting_position: Vector3 = global_position

var is_alerted: bool = false
var is_sus: bool = false
var patrolling_forward = true
var loop: bool:
	get:
		return patrol_path.curve.get_point_position(0) == patrol_path.curve.get_point_position(patrol_path.curve.point_count - 1)

var movement_speed: float:
	get: return alerted_speed if is_alerted else patrol_speed

func _ready() -> void:
	SignalBus.obstacle_activated.connect(_on_obstacle_activated)
	SignalBus.player_killed.connect(_on_player_killed)
	$SusTimer.wait_time = sus_time

	navigation_agent.path_desired_distance = 0.5
	navigation_agent.target_desired_distance = 0.5

	actor_setup.call_deferred(global_position)

func actor_setup(movement_target_position: Vector3):
	await get_tree().physics_frame
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _patrol_next_point(delta: float) -> Vector3:
	if not patrol_path:
		return starting_position
	
	if not (patrol_path.follow_path as PathFollow3D).loop:
		if patrolling_forward and (patrol_path.follow_path as PathFollow3D).progress_ratio == 1.0:
			patrolling_forward = false
		if not patrolling_forward and (patrol_path.follow_path as PathFollow3D).progress_ratio == 0:
			patrolling_forward = true
	
	patrol_path.follow_path.progress += (patrol_speed if patrolling_forward else -patrol_speed) * delta
	return patrol_path.follow_path.global_position

func _physics_process(delta: float):
	if not is_alerted and not is_sus:
			set_movement_target(_patrol_next_point(delta))

	if navigation_agent.is_navigation_finished():
		if is_alerted and not is_sus:
			_sus_start()
		return

	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()

func _on_obstacle_activated(new_position: Vector3) -> void:
	_on_alerted(new_position)

func _on_alerted(new_position: Vector3) -> void:
	$SusTimer.stop()
	is_alerted = true
	alert_start.emit()
	set_movement_target(new_position)

func _sus_start():
	is_sus = true
	$SusTimer.start()
	sus_start.emit()

func _on_sus_timer_timeout() -> void:
	_sus_end()

func _sus_end():
	is_sus = false
	_on_alert_end()
	sus_end.emit()

func _on_player_killed(killed_by: Object) -> void:
	_on_alert_end()

func _on_alert_end():
	is_alerted = false
	alert_end.emit()

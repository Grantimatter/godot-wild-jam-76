class_name Interactable extends Area3D
## Base class for objects that can be interacted with in the game world
##
## Full description

## The text prompt that appears when the player is able to interact
@export var start_tooltip: String = "Interact"
@export var complete_tooltip: String = "Interact"
@export var is_one_shot: bool = false
@export var interaction_range: float = .5
@onready var interact_key = InputMap.action_get_events("interact")[0].as_text().get_slice(" (", 0)

var is_interacting: bool = false
var can_interact: bool = true
@onready var current_tooltip = start_tooltip

func _ready() -> void:
	$Tooltip.text = _get_tooltip_text()
	$Tooltip.billboard = true

func _get_tooltip_text() -> String:
	if can_interact:
		return "[%s] %s" % [interact_key, current_tooltip]
	return current_tooltip

func _show_tooltip() -> void:
	if $Tooltip.visible or is_interacting:
		return
	$Tooltip.text = _get_tooltip_text()
	$Tooltip.show()

func _hide_tooltip() -> void:
	if not $Tooltip.visible:
		return
	$Tooltip.hide()

## Call when player will interact with this if they press the interact key
func start_interact() -> void:
	_show_tooltip()

## Call when player presses the interaction key
## returns true if the interaction will hold
func do_interact() -> void:
	is_interacting = true
	if is_one_shot:
		can_interact = false

	current_tooltip = complete_tooltip
	$Tooltip.text = _get_tooltip_text()

func end_interact() -> void:
	is_interacting = false
	_show_tooltip()

func stop_interact() -> void:
	_hide_tooltip()
	is_interacting = false

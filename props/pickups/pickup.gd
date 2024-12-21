class_name Pickup extends Interactable

@export var item: Item

func do_interact():
	SignalBus.player_collected.emit(item)
	super()
	end_interact()

func end_interact():
	super()
	queue_free()

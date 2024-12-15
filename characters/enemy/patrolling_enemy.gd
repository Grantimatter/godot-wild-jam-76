class_name PatrollingEnemy extends Enemy

func _ready():
	super()
	_follow_path()

func _on_sus_end():
	_follow_path()

func _on_player_killed(killed_by: Object):
	_follow_path()

func _follow_path():
	# Go back to patrol path
	pass

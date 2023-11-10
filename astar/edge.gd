extends Line2D

var from := -1 : set = set_from
var to := -1 : set = set_to

signal remove_connection(from, to)

func set_from(value):
	from = value

func set_to(value):
	to = value

func set_end_point(end: Vector2):
	clear_points()
	add_point(Vector2.ZERO)
	add_point(end)
	
	%"DeleteButton".position = end * 0.5

func delete():
	emit_signal("remove_connection", from, to)
	queue_free()

func _on_delete_button_pressed() -> void:
	delete()

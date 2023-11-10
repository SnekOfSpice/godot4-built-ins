extends Line2D

var from := -1 : set = set_from
var to := -1 : set = set_to

signal remove_connection(from, to)

func _ready() -> void:
	if Data.of("astar.bidirectional"):
		default_color = Color(0.8, 0.8, 0.8, 0.7)
		gradient = null
	else:
		var g = Gradient.new()
		g.add_point(0.0, Color.AQUAMARINE)
		g.add_point(1.0, Color.BROWN)
		gradient = g

func set_from(value):
	from = value

func set_to(value):
	to = value

func set_end_point(end: Vector2):
	clear_points()
	add_point(Vector2.ZERO)
	add_point(end)
	
	%"DeleteButton".position = end * 0.5 - %"DeleteButton".get_rect().size * 0.5

func delete():
	emit_signal("remove_connection", from, to)
	queue_free()

func _on_delete_button_pressed() -> void:
	delete()

extends Node2D

@onready var astar = AStar2D.new()
var is_connecting := false
var connecting_from := -1

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if is_connecting: return
			add_point(event.position)
			

func add_point(at: Vector2):
	var new_point = preload("res://astar/graph_point.tscn").instantiate()
	%"Points".add_child(new_point)
	new_point.position = at
	new_point.connect("delete_point", remove_point)
	new_point.connect("connecting", set_is_connecting)
	
	var point_id = astar.get_available_point_id()
	new_point.point_id = point_id
	astar.add_point(point_id, at, Data.of("astar.pointweight", 1))
	
	set_is_connecting(-1, false)

func _process(delta: float) -> void:
	queue_redraw()
	#printt(connecting_from, is_connecting)

func _draw() -> void:
	if is_connecting:
		draw_line(astar.get_point_position(connecting_from), get_local_mouse_position(), Color.ALICE_BLUE, 1.0)

func remove_point(id):
	for edge in %"Edges".get_children():
		if edge.from == id or edge.to == id:
			edge.delete()
	astar.remove_point(id)

func set_is_connecting(point_id: int, value: bool):
	var first_point = connecting_from
	connecting_from = point_id
	is_connecting = value
	
	printt(first_point, connecting_from, is_connecting)
	if first_point != connecting_from and is_connecting and first_point != -1:
		add_connection(first_point, connecting_from)
	

func add_connection(from:int, to:int):
	var first_pos = astar.get_point_position(from)
	var last_pos = astar.get_point_position(to)
	astar.connect_points(from, to, Data.of("astar.bidirectional", true))
	
	var new_edge = preload("res://astar/edge.tscn").instantiate()
	%"Edges".add_child(new_edge)
	new_edge.position = first_pos
	new_edge.set_end_point(last_pos - first_pos)
	new_edge.connect("remove_connection", remove_connection)
	new_edge.set_from(from)
	new_edge.set_to(to)
	
	set_is_connecting(-1, false)
	
	
	
#	for p in %"Points".get_children():
#		p.is_connecting_from = false

func remove_connection(from: int, to: int):
	astar.disconnect_points(from, to)
	for p in %"Points".get_children():
		p.is_connecting_from = false

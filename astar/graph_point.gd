extends Node2D

var point_weight := 1 : set = set_point_weight
var point_id := -1 : set = set_point_id
var is_connecting_from := false# : set = set_is_connecting_from
var is_mouse_inside := false

signal delete_point(point_id)
signal connecting(point_id, is_connecting_from)

func _ready() -> void:
	point_weight = Data.of("astar.pointweight", 1)
	set_is_connecting_from(false)

func set_point_weight(value):
	point_weight = value
	$"WeightLabel".text = str(point_weight)
	
func set_point_id(value):
	point_id = value
	$"IdLabel".text = str("ID ", point_id)
	if Data.point_objects.size() <= point_id:
		Data.point_objects.resize(point_id+1)
	Data.point_objects[point_id] = self
	
	for l in get_tree().get_nodes_in_group("pointObjectListeners"):
		l.on_point_objects_changed()
	

func set_is_connecting_from(value, silent:=false):
	is_connecting_from = value
	$Icon.modulate.a = 0.5 if not is_connecting_from else 1.0
	if not silent: emit_signal("connecting", point_id, is_connecting_from)
	prints("connecting ", point_id, ": ", is_connecting_from)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and is_mouse_inside:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				set_is_connecting_from(not is_connecting_from)
				get_viewport().set_input_as_handled()
			if event.button_index == MOUSE_BUTTON_RIGHT:
				delete()

func delete():
	Data.point_objects[point_id] = null
	Data.collapse_point_objects()
	emit_signal("delete_point", point_id)
	queue_free()

func _on_area_2d_mouse_entered() -> void:
	is_mouse_inside = true


func _on_area_2d_mouse_exited() -> void:
	is_mouse_inside = false

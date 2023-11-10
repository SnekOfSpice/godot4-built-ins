extends Node2D

var normal := Vector2.UP
var horizon := Vector2.RIGHT

var ref_pos := Vector2()

var horizon_rotation := 0.0

func _ready() -> void:
	var s = ""
	for a in $Arrows.get_children():
		s += str(a.get_index(), " - ", a.name)
		s += "\n"
	find_child("HotkeyLabel").text = s

func _process(delta: float) -> void:
	queue_redraw()
	
	var center_origin = get_viewport().size * 0.5
	var mouse_pos = get_local_mouse_position() - center_origin
	VectorLabels.mousePos = mouse_pos
	
	$Arrows/ToMouse.position = center_origin
	$Arrows/ToMouse.origin = Vector2.ZERO
	$Arrows/ToMouse.target = mouse_pos
	
	$Arrows/Bounce.position = center_origin
	$Arrows/Bounce.origin = Vector2.ZERO
	$Arrows/Bounce.target = (mouse_pos).bounce(normal)
	$Arrows/Bounce.label_prefix = str(".bounce(", normal,")")
	
	$Arrows/Abs.position = center_origin
	$Arrows/Abs.origin = Vector2.ZERO
	$Arrows/Abs.target = abs(mouse_pos)
	
	$Arrows/Reference.position = center_origin
	$Arrows/Reference.origin = Vector2.ZERO
	$Arrows/Reference.target = ref_pos
	
	$Arrows/Project.position = center_origin
	$Arrows/Project.origin = Vector2.ZERO
	$Arrows/Project.target = mouse_pos.project(ref_pos)
	
	$Arrows/Orthogonal.position = center_origin
	$Arrows/Orthogonal.origin = Vector2.ZERO
	$Arrows/Orthogonal.target = mouse_pos.orthogonal()
	
	$Arrows/Reflect.position = center_origin
	$Arrows/Reflect.origin = Vector2.ZERO
	$Arrows/Reflect.target = mouse_pos.reflect(normal)
	
	$Arrows/Slerp.position = center_origin
	$Arrows/Slerp.origin = Vector2.ZERO
	$Arrows/Slerp.target = mouse_pos.slerp(normal, 0.5)
	
	$Arrows/Slide.position = center_origin
	$Arrows/Slide.origin = Vector2.ZERO
	$Arrows/Slide.target = mouse_pos.slide(normal)
	
	#$StoredLabel.position = get_local_mouse_position()
	
	VectorLabels.store_string("-------")
	VectorLabels.store_string(str(".angle(): ", mouse_pos.angle()))
	VectorLabels.store_string(str(".aspect(): ", mouse_pos.aspect()))
	VectorLabels.store_string(str(".cross(ref): ", mouse_pos.cross(ref_pos)))
	VectorLabels.store_string(str(".dot(ref): ", mouse_pos.dot(ref_pos)))
	
	
	find_child("StoredLabel").text = VectorLabels.concat_stored_strings()
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			$Horizon.rotation_degrees += 1
			normal = normal.rotated(PI*0.01)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			$Horizon.rotation_degrees -= 1
			normal = normal.rotated(PI*-0.01)
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				ref_pos = VectorLabels.mousePos
	
	if event is InputEventKey:
		if event.keycode == KEY_SPACE:
			$Horizon.rotation_degrees = 0
			normal = Vector2.UP
		if event.keycode == KEY_LEFT:
			ref_pos = Vector2.LEFT * get_viewport().size.x * 0.25
		if event.keycode == KEY_RIGHT:
			ref_pos = Vector2.RIGHT * get_viewport().size.x * 0.25
		if event.keycode == KEY_UP:
			ref_pos = Vector2.UP * get_viewport().size.y * 0.25
		if event.keycode == KEY_DOWN:
			ref_pos = Vector2.DOWN * get_viewport().size.y * 0.25

func _draw() -> void:
	draw_line(get_viewport().size * 0.5, get_viewport().size * 0.5 + normal * 500, Color.GREEN, 1.0)




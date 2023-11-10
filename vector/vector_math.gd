extends Node2D

var normal := Vector2.UP
var horizon := Vector2.RIGHT

var horizon_rotation := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	
	var center_origin = get_viewport().size * 0.5
	var mouse_pos = get_local_mouse_position() - center_origin
	
	$Arrows/ToMouse.position = center_origin
	$Arrows/ToMouse.origin = Vector2.ZERO
	$Arrows/ToMouse.target = mouse_pos
	$Arrows/ToMouse.set_text(str("Mouse Pos: ", $Arrows/ToMouse.target))
	
	$Arrows/Bounce.position = center_origin
	$Arrows/Bounce.origin = Vector2.ZERO
	$Arrows/Bounce.target = (mouse_pos).bounce(normal)
	$Arrows/Bounce.set_text(str("Bounce: ", $Arrows/Bounce.target))
	
	$Arrows/Abs.position = center_origin
	$Arrows/Abs.origin = Vector2.ZERO
	$Arrows/Abs.target = abs(mouse_pos)
	$Arrows/Abs.set_text(str("Abs: ", $Arrows/Abs.target))
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			$Horizon.rotation_degrees += 1
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			$Horizon.rotation_degrees -= 1
	
	if event is InputEventKey:
		if event.keycode == KEY_SPACE:
			$Horizon.rotation_degrees = 0

func _draw() -> void:
	draw_line(get_viewport().size * 0.5, get_viewport().size * 0.5 + normal * 500, Color.GREEN, 1.0)




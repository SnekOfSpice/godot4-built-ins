extends Line2D
class_name Arrow

var origin := Vector2.ZERO
var target:= Vector2.ZERO

#@export_color_no_alpha var arrow_color := Color.WHITE
@export var label_prefix := ""

func _ready() -> void:
	clear_points()
	add_point(Vector2.ZERO)
	add_point(Vector2.ZERO)
	
	$Arrowhead.modulate = default_color
	$Label.modulate = default_color
	

func _process(delta: float) -> void:
#	update_positions()
	
	set_point_position(0, origin)
	set_point_position(1, target)
	
	if not find_child("Arrowhead"):
		return
	var dir = target-origin
	$Arrowhead.rotation = atan2(dir.y, dir.x) + PI * 0.5
	$Arrowhead.position = target
	
	if not visible:
		return
	if target.distance_to(VectorLabels.mousePos) < 10:
		$Label.visible = false
		VectorLabels.store_string(str(label_prefix, ": ", target))
	else:
		set_text(str(label_prefix, ": ", target))
		$Label.position = target
		$Label.visible = true

func set_text(new_text: String):
	$Label.text = new_text

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.as_text_key_label() == str(get_index()):
			visible = not visible

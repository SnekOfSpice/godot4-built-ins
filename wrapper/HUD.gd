extends Control

signal find_path(from, to)

func _ready() -> void:
	%"PointWeightLabel".text = str(Data.of("astar.pointweight", %"PointWeightSlider".value))
	Data.apply("astar.bidirectional", %"BidirectionalCheckBox".button_pressed)

func on_point_objects_changed():
	%"StartBox".max_value = Data.point_objects.size() - 1
	%"EndBox".max_value = Data.point_objects.size() - 1

func _on_point_weight_slider_value_changed(value: float) -> void:
	%"PointWeightLabel".text = str(value)
	Data.apply("astar.pointweight", value)


func _on_bidirectional_check_box_pressed() -> void:
	Data.apply("astar.bidirectional", %"BidirectionalCheckBox".button_pressed)


func _on_find_path_button_pressed() -> void:
	emit_signal("find_path", %"StartBox".value, %"EndBox".value)

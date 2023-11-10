extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%"PointWeightLabel".text = str(Data.of("astar.pointweight", %"PointWeightSlider".value))
	Data.apply("astar.bidirectional", %"BidirectionalCheckBox".button_pressed)



func _on_point_weight_slider_value_changed(value: float) -> void:
	%"PointWeightLabel".text = str(value)
	Data.apply("astar.pointweight", value)


func _on_bidirectional_check_box_pressed() -> void:
	Data.apply("astar.bidirectional", %"BidirectionalCheckBox".button_pressed)

extends Control


@onready var value_edit = find_child("ValueEdit")


func calculate_everything():
	var value = float(value_edit.text)
	if value_edit.text == str(INF):
		value = INF
	if value_edit.text == str(-INF):
		value = -INF
		
	for c in $HBoxContainer/ResultContainer.get_children():
		c.queue_free()
	
	make_new_label(str("abs ", abs(value)))
	make_new_label(str("atan ", atan(value)))

func make_new_label(text: String):
	var new_label = Label.new()
	$HBoxContainer/ResultContainer.add_child(new_label)
	new_label.text = text

func _on_pi_button_pressed() -> void:
	value_edit.text = str(PI)


func _on_zero_button_pressed() -> void:
	value_edit.text = str(0)


func _on_neg_inf_button_pressed() -> void:
	value_edit.text = str(-INF)


func _on_inf_button_pressed() -> void:
	value_edit.text = str(INF)


func _on_tau_button_pressed() -> void:
	value_edit.text = str(TAU)
	

func _on_three_sixty_button_pressed() -> void:
	value_edit.text = str(360)


func _on_calculate_everything_button_pressed() -> void:
	calculate_everything()

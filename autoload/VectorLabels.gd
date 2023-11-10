extends Node

var strings := []
var mousePos := Vector2()

func store_string(s: String):
	strings.append(s)

func _process(delta: float) -> void:
	pass

func concat_stored_strings() -> String:
	var result = ""
	
	for s in strings:
		result += s
		result += "\n"
	
	strings.clear()
	return result

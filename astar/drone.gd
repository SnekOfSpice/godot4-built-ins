extends Node2D


var speed := 10.0

func move_along_path(path: PackedVector2Array):
	if path.size() <= 0:
		return
	print(path)
	var tween = create_tween()
	var last_point = path[0]
	#var total_distance := 0.0
	for point in path:
		var d = point.distance_to(last_point) / 150.0
		print(d)
		tween.tween_property(self, "position", point, d)#.set_delay(total_distance * (1/speed))
		#total_distance += point.distance_to(last_point)
		last_point = point
	
	tween.connect("finished", queue_free)

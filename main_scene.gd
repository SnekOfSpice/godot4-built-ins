extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SubViewportContainer/SubViewport.size = get_window().size
	get_window().connect("size_changed", window_size_changed)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func window_size_changed():
	$SubViewportContainer/SubViewport.size = get_window().size

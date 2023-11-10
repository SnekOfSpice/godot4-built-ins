extends Node

var properties := {}
var listeners := {}

func of(key: String, default=-1):
	if not properties.keys().has(key):
		return default
	
	return properties.get(key)

func apply(key: String, value):
	var key_listeners : Array = listeners.get(key, [])
	var i = 0
	var size = key_listeners.size()
	while i < size:
		if not is_instance_valid(key_listeners[i]):
			key_listeners.remove_at(i)
			i -= 1
			size = key_listeners.size()
		i += 1
	
	listeners[key] = key_listeners
	
	var old_value = of(key, null)
	properties[key] = value
	
	for l in listeners.get(key, []):
		l.property_changed(key, value, old_value)

func listen(listener, key:String, immediate_callback:=false):
	var current_listeners : Array = listeners.get(key, [])
	if current_listeners.has(listener):
		return
	
	current_listeners.append(listener)
	listeners[key] = current_listeners
	
	if immediate_callback:
		listener.property_changed(key, of(key), of(key))

func unlisten(listener, key:String):
	var current_listeners : Array = listeners.get(key, [])
	if not current_listeners.has(listener):
		return
	
	current_listeners.erase(listener)
	listeners[key] = current_listeners

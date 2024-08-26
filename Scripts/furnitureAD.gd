extends TextureButton

signal order_furniture

@export var furniture_type : PackedScene

func _on_pressed():
	emit_signal("order_furniture", furniture_type)

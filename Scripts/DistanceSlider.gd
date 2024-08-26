extends Control

@onready var slider = $HSlider
@onready var slider_label = $"Furniture Distance Label"
@onready var game_manager = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.furniture_speed = slider.value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_manager.focused_furniture != null:
		self.visible = true
	else:
		self.visible = false
	slider_label.text = "Placement Distance: " + str(slider.value) + "m"
	game_manager.furniture_speed = slider.value

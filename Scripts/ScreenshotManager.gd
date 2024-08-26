extends Control

var screenshot_count = 1

@onready var screenshot_label = $ScreenshotText
@onready var label_timer = $Timer
@onready var shutter_sound : AudioStreamPlayer = $ShutterSound

# Called when the node enters the scene tree for the first time.
func _ready():
	var dir = DirAccess.open("user://")
	dir.make_dir("Screenshots")
	
	dir = DirAccess.open("user://Screenshots")
	for n in dir.get_files():
		screenshot_count += 1

func screenshot():
	get_parent().visible = false
	await RenderingServer.frame_post_draw
	
	var dir = DirAccess.open("user://Screenshots")
	
	screenshot_label.text = "Screenshot was saved at AppData\\Roaming\\IKEA HOME Decorator\\Screenshots"
	screenshot_label.visible = true
	label_timer.stop()
	label_timer.start()
	
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	img.save_png("user://Screenshots/ss"+str(screenshot_count)+".png")
	screenshot_count += 1
	shutter_sound.play()
	get_parent().visible = true


func _on_texture_button_pressed():
	screenshot()


func _on_timer_timeout():
	screenshot_label.visible = false

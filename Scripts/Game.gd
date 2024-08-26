extends Node3D

var focused_furniture : Node3D = null
@onready var camera : Camera3D = $Camera3D
@onready var speed_slider : HSlider = %HSlider
@onready var trashcan_button = %Trashcan

@onready var move_sound : AudioStreamPlayer = $SoundFX/MoveSound
@onready var rotate_sound : AudioStreamPlayer = $SoundFX/RotateSound

var max_furniture_y : float = 5
var min_furniture_y : float = 2
var max_furniture_x_and_z : float = 7
var min_furniture_x_and_z : float = 7
var furniture_speed : float

func _physics_process(delta):
	if Input.is_action_just_pressed("zoom_in") && camera.size > 3:
		camera.size -= 0.5
	elif Input.is_action_just_pressed("zoom_out") && camera.size < 15:
		camera.size += 0.5
	if focused_furniture:
		if Input.is_action_just_pressed("rotate_clockwise"):
			focused_furniture.rotate(Vector3.DOWN, deg_to_rad(90))
			rotate_sound.play()
		elif Input.is_action_just_pressed("rotate_counterclockwise"):
			focused_furniture.rotate(Vector3.UP, deg_to_rad(90))
			rotate_sound.play()
		elif Input.is_action_just_pressed("rotate_up"):
			focused_furniture.rotate(Vector3.RIGHT, deg_to_rad(90))
			rotate_sound.play()
		elif Input.is_action_just_pressed("rotate_down"):
			focused_furniture.rotate(Vector3.LEFT, deg_to_rad(90))
			rotate_sound.play()
		if Input.is_action_just_pressed("move_left"):
			focused_furniture.position = Vector3(
					focused_furniture.position.x,
					focused_furniture.position.y,
					focused_furniture.position.z + furniture_speed
					)
			check_furniture_distance()
			camera.update_camera_target(focused_furniture)
			move_sound.play()
		elif Input.is_action_just_pressed("move_right"):
			focused_furniture.position = Vector3(
					focused_furniture.position.x,
					focused_furniture.position.y,
					focused_furniture.position.z - furniture_speed
					)
			check_furniture_distance()
			camera.update_camera_target(focused_furniture)
			move_sound.play()
		elif Input.is_action_just_pressed("move_forward"):
			focused_furniture.position = Vector3(
					focused_furniture.position.x - furniture_speed,
					focused_furniture.position.y,
					focused_furniture.position.z
					)
			check_furniture_distance()
			camera.update_camera_target(focused_furniture)
			move_sound.play()
		elif Input.is_action_just_pressed("move_back"):
			focused_furniture.position = Vector3(
					focused_furniture.position.x + furniture_speed,
					focused_furniture.position.y,
					focused_furniture.position.z
					)
			check_furniture_distance()
			camera.update_camera_target(focused_furniture)
			move_sound.play()
		elif Input.is_action_just_pressed("move_up"):
			focused_furniture.position = Vector3(
					focused_furniture.position.x,
					focused_furniture.position.y + furniture_speed,
					focused_furniture.position.z
					)
			check_furniture_distance()
			camera.update_camera_target(focused_furniture)
			move_sound.play()
		elif Input.is_action_just_pressed("move_down"):
			focused_furniture.position = Vector3(
					focused_furniture.position.x,
					focused_furniture.position.y - furniture_speed,
					focused_furniture.position.z
					)
			check_furniture_distance()
			camera.update_camera_target(focused_furniture)
			move_sound.play()
		if Input.is_action_just_pressed("unfocus"):
			focused_furniture.main_collision.visible = true
			focused_furniture.set_collision_layer_value(1, true)
			focused_furniture = null
			trashcan_button.visible = false
			camera.back_to_default_position()

func check_furniture_distance():
	if focused_furniture.position.x > max_furniture_x_and_z:
		focused_furniture.position.x = max_furniture_x_and_z
	elif focused_furniture.position.x < -min_furniture_x_and_z:
		focused_furniture.position.x = -min_furniture_x_and_z
	
	if focused_furniture.position.y > max_furniture_y:
		focused_furniture.position.y = max_furniture_y
	elif focused_furniture.position.y < -min_furniture_y:
		focused_furniture.position.y = -min_furniture_y
	
	if focused_furniture.position.z > max_furniture_x_and_z:
		focused_furniture.position.z = max_furniture_x_and_z
	elif focused_furniture.position.z < -min_furniture_x_and_z:
		focused_furniture.position.z = -min_furniture_x_and_z

func _on_furniture_furniture_clicked(furniture):
	# Check if clicked furniture is the same as the currently focused furniture.
	if furniture != focused_furniture:
		camera.back_to_default_position()
		if focused_furniture != null:
			focused_furniture.main_collision.visible = true
			focused_furniture.set_collision_layer_value(1, true)
		focused_furniture = furniture
	trashcan_button.visible = true
	camera.update_camera_target(focused_furniture)
	furniture.main_collision.visible = false
	furniture.set_collision_layer_value(1, false)

func delete_furniture():
	if focused_furniture != null:
		trashcan_button.visible = false
		focused_furniture.queue_free()
		camera.back_to_default_position()

func _on_trashcan_pressed():
	delete_furniture()

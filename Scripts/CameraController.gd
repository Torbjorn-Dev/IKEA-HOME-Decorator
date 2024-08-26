extends Camera3D

@onready var default_position = $"../Default Camera Position".position
var camera_offset_xz = 10.5
var camera_offset_y = 11.787
var target_position

# Called when the node enters the scene tree for the first time.
func _ready():
	back_to_default_position()

func back_to_default_position():
	size = 15
	target_position = Vector3(
			default_position.x + 7, 
			default_position.y + camera_offset_y, 
			default_position.z + 7
			)
			
func update_camera_target(object):
	target_position = Vector3(
			object.position.x + camera_offset_xz, 
			object.position.y + camera_offset_y, 
			object.position.z + camera_offset_xz
			)

func _physics_process(delta):
	position = lerp(position, target_position, 0.25)

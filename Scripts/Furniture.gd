extends StaticBody3D

signal furniture_clicked
@onready var box : Node3D = $BoxMesh
@onready var unbox_sound : AudioStreamPlayer = $UnboxSound
@onready var drill_sound : AudioStreamPlayer = $DrillSound
@onready var main_collision : CollisionShape3D = %MainCollision
@onready var assembly_points : Node3D = $AssemblyPoints
var unboxed : bool = false

func _on_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if unboxed:
				emit_signal("furniture_clicked", self)
			else:
				unbox()

func unbox():
	if assembly_points != null:
		assembly_points.visible = true
	unbox_sound.play()
	box.visible = false
	unboxed = true

func assembled_part():
	drill_sound.play()

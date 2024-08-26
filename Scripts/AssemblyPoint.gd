extends StaticBody3D

signal assembled_part

@onready var assembly_collider : CollisionShape3D = $AssemblyCollider
@onready var assembled_meshes : Node3D = $AssembledMeshes
@onready var assembly_marker : Sprite3D = $AssemblyMarker

var part_assembled = false

func _ready():
	connect("input_event", self._on_input_event)

func _on_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT && !part_assembled:
			assembled_meshes.visible = true
			assembly_marker.visible = false
			assembly_collider.visible = false
			part_assembled = true
			connect("assembled_part", get_parent().get_parent().assembled_part)
			emit_signal("assembled_part")


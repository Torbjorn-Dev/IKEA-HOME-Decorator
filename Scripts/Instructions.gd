extends Control

@onready var instruction_paper = $InstructionMenu
@onready var guide_arrow = $GuideArrow
var instructions_checked = false

func _on_texture_button_pressed():
	instruction_paper.visible = !instruction_paper.visible
	if !instructions_checked:
		instructions_checked = true
		guide_arrow.queue_free()

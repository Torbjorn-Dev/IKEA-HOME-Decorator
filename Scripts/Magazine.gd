extends Control

var is_assembling : bool = false
@onready var room = %Room
@onready var purchase_sound : AudioStreamPlayer = $PurchaseSound
@onready var magazine_menu = $MagazineMenu

var pages : Array = []
var current_page : int = 0

func _ready():
	pages = $MagazineMenu/Pages.get_children()
	print(pages)

func order_furniture(furniture):
	#if not is_assembling:
		#print("You ordered: " + str(furniture))
		#var spawned_furniture = furniture.instantiate()
		#spawned_furniture.connect("furniture_clicked", get_parent().get_parent()._on_furniture_furniture_clicked)
		#room.add_child(spawned_furniture)
		#is_assembling = true
	#else:
		#print("You must finish building the current furniture")
	open_close_menu()
	print("You ordered: " + str(furniture))
	var spawned_furniture = furniture.instantiate()
	spawned_furniture.connect("furniture_clicked", get_parent().get_parent()._on_furniture_furniture_clicked)
	room.add_child(spawned_furniture)
	spawned_furniture.position = Vector3(spawned_furniture.position.x, spawned_furniture.position.y + 1, spawned_furniture.position.z)
	purchase_sound.play()
	is_assembling = true


func _on_texture_button_order_furniture(packedscene):
	order_furniture(packedscene)
	
func open_close_menu():
	magazine_menu.visible = !magazine_menu.visible

func _on_texture_button_pressed():
	open_close_menu()

func _on_back_button_pressed():
	print(pages[current_page])
	pages[current_page].visible = false
	current_page -= 1
	pages[current_page].visible = true

func _on_next_button_pressed():
	print(pages[current_page])
	pages[current_page].visible = false
	current_page += 1
	pages[current_page].visible = true

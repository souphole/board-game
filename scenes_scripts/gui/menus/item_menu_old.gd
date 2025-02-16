class_name ItemMenuOld
extends Menu

@export var item_slots: Array[ItemButton]

@export var name_label: Label

@export var description_label: Label

@export var use_button: Button

@export var drop_button: Button

var button_group: ButtonGroup

func _ready() -> void:
	
	button_group = item_slots[0].button_group
	
	inventory.inventory_changed.connect(update_buttons)
	
	for slot in item_slots:
		slot.toggled.connect(update_name_and_description.bind(slot))
		
	use_button.pressed.connect(func():
		inventory.use_item(button_group.get_pressed_button().get_index())
	)
	
	drop_button.pressed.connect(func():
		inventory.drop_item(button_group.get_pressed_button().get_index())
	)

func update_buttons():
	for slot in item_slots:
		slot.item = null
		slot.update_image()
		
	for item_index in len(inventory.inventory_array):
		item_slots[item_index].item = inventory.inventory_array[item_index]
		item_slots[item_index].update_image()

func update_name_and_description(toggled: bool, slot: ItemButton):
	if toggled:
		name_label.text = slot.item.item_name
		description_label.text = slot.item.item_description
	else:
		name_label.text = ""
		description_label.text = ""
	update_use_and_drop(toggled)
	
func update_use_and_drop(is_item_selected: bool):
	use_button.disabled = not is_item_selected
	drop_button.disabled = not is_item_selected

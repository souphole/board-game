extends DefaultButton

@export var root_parent: GUI

@export var line_edit: LineEdit

func _pressed() -> void:
	var new_item = root_parent.items.find_child(line_edit.text).duplicate()
	inventory.add_item(new_item)
	print(inventory.inventory_array)

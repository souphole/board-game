extends DefaultButton

func _pressed() -> void:
	var dice_queue = global_dict.get_data("dice_queue")
	
	parent_menu.parent.gui.pressed_roll.emit()

extends DefaultButton

func _pressed() -> void:
	if global_values.add_default_roll_die:
		global_values.dice_queue.append(global_values.die_normal.instantiate())
	
	parent_menu.parent.gui.pressed_roll.emit()

extends DefaultButton

var roll_disabled := false

func _pressed() -> void:
	if global_values.roll_enabled:
		
		if global_values.add_default_roll_die:
			global_values.dice_queue.append(dice.die_normal.instantiate())
		
		print(global_values.dice_queue)
		
		parent_menu.parent.gui.pressed_roll.emit()

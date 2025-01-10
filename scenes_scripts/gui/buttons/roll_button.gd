extends DefaultButton

func _pressed() -> void:
	parent_menu.parent.gui.pressed_roll.emit()

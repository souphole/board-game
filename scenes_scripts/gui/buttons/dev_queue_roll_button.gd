extends DefaultButton

@export var min_spinbox: SpinBox
@export var max_spinbox: SpinBox
@export var override_spinbox: SpinBox

func _pressed() -> void:
	var dice_queue = global_dict.get_data("dice_queue")
	if dice_queue == null:
		dice_queue = []
		
	dice_queue.append({"min": min_spinbox.value, "max": max_spinbox.value, "override": override_spinbox.value})
	print(dice_queue)
	global_dict.store_data("dice_queue", dice_queue)

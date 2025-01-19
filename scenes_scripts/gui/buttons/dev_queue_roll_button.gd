extends DefaultButton

@export var die_type: LineEdit
@export var min_spinbox: SpinBox
@export var max_spinbox: SpinBox
@export var override_spinbox: SpinBox
@export var dice_mod_spinbox: SpinBox
@export var add_roll_die_check: CheckButton

func _ready() -> void:
	
	super()
	
	add_roll_die_check.toggled.connect(func(toggled):
		global_values.add_default_roll_die = toggled
	)
	
func _pressed() -> void:
	var dice_queue = global_values.dice_queue
	
	var new_die: Die
	
	match die_type.text:
		"aurora":
			new_die = global_values.die_aurora.instantiate()
		_:
			new_die = global_values.die_normal.instantiate()
	
	new_die.min = min_spinbox.value
	new_die.max = max_spinbox.value
	new_die.override = override_spinbox.value
	global_values.dice_mod = dice_mod_spinbox.value
		
	dice_queue.append(new_die)

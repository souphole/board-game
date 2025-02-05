extends State

@export_group("Player Action")
@export var prepare_move: State

@export var prepare_dice: State

@export_group("Spaces")
@export var default_item: State

var reference_state: State

func init() -> void:
	parent.gui.pressed_roll.connect(func(): 
		reference_state = prepare_dice
		global_values.roll_enabled = false
		parent.gui.menu_manager.hide_menu()
	)

func enter() -> void:
	super()
	reference_state = null
	
	if parent.spaces_to_move > 0: 
		reference_state = prepare_move
	else:
		parent.dice_container.remove_final_hit_label()
		
		if parent.gui.menu_manager.is_menu_hidden:
			global_values.roll_enabled = true
			parent.gui.menu_manager.show_menu()
			
		inventory.update_lifespans()
		print(inventory.used_items)
		
		check_space()

func process_input(event: InputEvent) -> State:
	#dev actions and such. good for testing
	if parent.dev:
		if Input.is_action_just_pressed("dev_move"):
			return prepare_move
	
	return null
	
func check_space():
	if parent.current_space.type == "default_item":
			reference_state = default_item
	
func process(delta: float) -> State:
	return reference_state

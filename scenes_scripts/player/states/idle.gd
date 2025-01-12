extends State

@export var prepare_move: State

@export var prepare_dice: State

var reference_state: State

func enter() -> void:
	super()
	reference_state = null
	
	parent.gui.pressed_roll.connect(func(): reference_state = prepare_dice)
	
	if parent.spaces_to_move > 0: 
		
		if not parent.gui.menu_manager.is_menu_hidden:
			parent.gui.menu_manager.hide_menu()
			
		reference_state = prepare_move
	else:
		parent.dice_container.remove_final_hit_label()
		
		if parent.gui.menu_manager.is_menu_hidden:
			parent.gui.menu_manager.show_menu()

func process_input(event: InputEvent) -> State:
	#dev actions and such. good for testing
	if parent.dev:
		if Input.is_action_just_pressed("dev_move"):
			return prepare_move
	
	return null
	
func process(delta: float) -> State:
	return reference_state

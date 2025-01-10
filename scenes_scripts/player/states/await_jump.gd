extends State

@export var idle: State
@export var jumping: State

func process_input(event: InputEvent) -> State:
	
	if Input.is_action_just_pressed("jump") && not parent.dice_container.finished:
		return jumping
	
	return null

func process(delta: float) -> State:
	
	if parent.dice_container.finished:
		
		parent.spaces_to_move = parent.dice_container.get_final_hit_label_value()
		
		return idle
	
	return null

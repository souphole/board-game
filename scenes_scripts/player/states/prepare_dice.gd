extends State

@export var await_jump: State

func enter() -> void:
	super()
	var dice_queue = global_dict.get_data("dice_queue")
	
	parent.dice_container.spawn_dice(parent, dice_queue)
	
	global_dict.store_data("dice_queue", [])

func process(delta: float) -> State:
	return await_jump

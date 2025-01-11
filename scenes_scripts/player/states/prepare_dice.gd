extends State

@export var await_jump: State

func enter() -> void:
	super()
	
	var dice_queue = global_dict.get_data("dice_queue")
	var dice_mod = global_dict.get_data("dice_mod")
	
	parent.dice_container.spawn_dice(parent, dice_queue, dice_mod)
	
	global_dict.store_data("dice_queue", [])
	global_dict.store_data("dice_mod", null)

func process(delta: float) -> State:
	return await_jump

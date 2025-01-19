extends State

@export var await_jump: State

func enter() -> void:
	super()
	
	var dice_queue = global_values.dice_queue
	var dice_mod = global_values.dice_mod
	
	parent.dice_container.spawn_dice(parent, dice_queue, dice_mod)
	
	global_values.dice_queue = []
	global_values.dice_mod = 0

func process(delta: float) -> State:
	return await_jump

extends State

@export var idle: State

func enter() -> void:
	super()
	parent.position = parent.current_space.global_position
	
func process(delta: float) -> State:
	return idle

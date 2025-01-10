extends State

@export var move: State

@export var spawn_arrows: State

func enter() -> void:
	super()

func process(delta) -> State:
	if parent.current_space.has_branch_nodes:
		return spawn_arrows
		
	elif parent.current_space.last_node:
		parent.current_space = parent.current_space.branch_nodes[0]
		parent.current_path = parent.current_space.get_parent()
		parent.path_index = parent.current_space.get_index()
		return move
	
	parent.path_index += 1
	parent.current_space = parent.current_path.get_child(parent.path_index)
	
	return move

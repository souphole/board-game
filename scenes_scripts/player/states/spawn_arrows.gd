extends State

@export var awaiting_arrow_click: State

@export var arrow_radius: int = 200

var arrow_scene = preload("res://scenes_scripts/gui/buttons/arrow_button.tscn")

func enter() -> void:
	super()
	
	for branch in parent.current_space.branch_nodes:
		spawn_arrow(parent.position, branch.global_position, branch)
	
	if not parent.current_space.last_node:
		var next_space = parent.current_path.get_child(parent.path_index + 1)
		
		if next_space != null:
			spawn_arrow(parent.position, next_space.global_position, next_space)
			
			
func process(delta: float) -> State:
	return awaiting_arrow_click

func spawn_arrow(pos1: Vector2, pos2: Vector2, reference_space) -> void:
	
	var arrow = arrow_scene.instantiate()
	
	arrow.z_index = 2
	
	arrow.position = (Vector2(pos2 - pos1).normalized() * arrow_radius)
	
	arrow.rotation = Vector2.RIGHT.angle_to(Vector2(pos2 - pos1).normalized()) - PI/2
	
	arrow.reference_space = reference_space
	
	parent.add_child(arrow)

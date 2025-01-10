extends State

@export var move: State

var arrows: Array

func enter() -> void:
	super()
	
	for child in parent.get_children():
		if child is Arrow:
			arrows.append(child)

func exit():
	for arrow in arrows:
		parent.remove_child(arrow)
	arrows.clear()
	
func process(delta: float) -> State:
	for arrow in arrows:
		
		if arrow.button.button_pressed:
			
			parent.current_space = arrow.reference_space
			parent.current_path = arrow.reference_space.get_parent()
			parent.path_index = arrow.reference_space.get_index()
			
			return move
	
	return null

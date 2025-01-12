extends State

@export var idle: State

var reference_state: State

func enter() -> void:
	super()
	
	# A little sloppy but this is the best solution I can think of right now
	
	if parent.spaces_to_move > 0: #this for if the movement is caused by dev_move so it doesnt subtract indefinitelyfuck you im
		parent.spaces_to_move -= 1
		parent.dice_container.set_final_hit_label_value(parent.spaces_to_move)
		
	reference_state = null
	
	var tween = create_tween()
	
	tween.finished.connect(func(): reference_state = idle) #avoids having to use await and therefore making process async
	
	tween.tween_property(parent, "global_position", parent.current_space.global_position, 0.25)

func process(delta: float) -> State:
	return reference_state

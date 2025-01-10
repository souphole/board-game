extends State

@export var await_jump: State

var reference_state: State

func enter() -> void:
	super()
	jumping()
	
func jumping():
	var sprite_height = parent.sprite.sprite_frames.get_frame_texture(parent.sprite.animation, parent.sprite.frame).get_height()
	
	var sprite_resting_position = parent.sprite.position
	
	var jump_height = parent.dice_container.position.y + sprite_height
	
	var tween = create_tween()
	tween.tween_property(parent.sprite, "position", Vector2(0, jump_height), 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	await tween.finished
	parent.hit_die.emit()
	
	tween = create_tween()
	tween.tween_property(parent.sprite, "position", sprite_resting_position, 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)

	await tween.finished
	
	reference_state = await_jump

func process(delta: float) -> State:
	return reference_state

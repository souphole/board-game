class_name TweenButton
extends Button

#taken from this post https://forum.godotengine.org/t/how-to-tween-transition-between-button-states-styleboxes/46889/2

var tween_stylebox:StyleBoxFlat
var styleboxes:Dictionary = {}
var current_state = BaseButton.DRAW_NORMAL

var tween:Tween

func _ready() -> void:
	# Duplicate the normal stylebox. We are going to use it as our base stylebox
	tween_stylebox = get_theme_stylebox('normal').duplicate()
	# Save the different styleboxes to be able to tween between their properties later
	styleboxes[BaseButton.DRAW_NORMAL] = get_theme_stylebox('normal').duplicate()
	styleboxes[BaseButton.DRAW_HOVER] = get_theme_stylebox('hover').duplicate()
	styleboxes[BaseButton.DRAW_PRESSED] = get_theme_stylebox('pressed').duplicate()
	styleboxes[BaseButton.DRAW_HOVER_PRESSED] = get_theme_stylebox('pressed').duplicate()
	styleboxes[BaseButton.DRAW_DISABLED] = get_theme_stylebox('disabled').duplicate()
	# Override all the other styleboxes with our tween stylebox
	add_theme_stylebox_override('normal', tween_stylebox)
	add_theme_stylebox_override('hover', tween_stylebox)
	add_theme_stylebox_override('pressed', tween_stylebox)


func _process(delta: float) -> void:
	if get_draw_mode() != current_state:
		# If the draw mode changed
		current_state = get_draw_mode()
		# Kill the running tween
		if tween and tween.is_running():
			tween.kill()
		# And create a new one
		tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
		# That tweens some properties of our tween stylebox to the target stylebox@export var add_roll_die_check: CheckButton
		# depending on the current state
		var target = styleboxes[current_state] as StyleBoxFlat
		tween.tween_property(tween_stylebox, "bg_color", target.bg_color, 0.2)
		tween.tween_property(tween_stylebox, "border_color", target.border_color, 0.2)
		tween.tween_property(tween_stylebox, "corner_radius_top_left", target.corner_radius_top_left, 0.2)
		tween.tween_property(tween_stylebox, "corner_radius_top_right", target.corner_radius_top_right, 0.2)
		tween.tween_property(tween_stylebox, "corner_radius_bottom_left", target.corner_radius_bottom_left, 0.2)
		tween.tween_property(tween_stylebox, "corner_radius_bottom_right", target.corner_radius_bottom_right, 0.2)
		tween.tween_property(tween_stylebox, "expand_margin_top", target.expand_margin_top, 0.2)
		tween.tween_property(tween_stylebox, "expand_margin_right", target.expand_margin_right, 0.2)
		tween.tween_property(tween_stylebox, "expand_margin_left", target.expand_margin_left, 0.2)
		tween.tween_property(tween_stylebox, "expand_margin_bottom", target.expand_margin_bottom, 0.2)

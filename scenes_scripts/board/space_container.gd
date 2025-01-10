@tool
class_name SpaceContainer
extends Node2D

var default_font : Font = ThemeDB.fallback_font;
@export var alt_path = false

func _ready() -> void:
	for i in get_child_count():
		get_child(i).name = str(i)

#only appears editor 
func _draw() -> void:
	if Engine.is_editor_hint():
		var color = Color("WHITE")
		if alt_path:
			color = Color("GREEN")
		for i in get_child_count():
			var text_position = get_child(i).position + Vector2(0, -40)
			draw_string(default_font, text_position, str(i), HORIZONTAL_ALIGNMENT_CENTER, 270, 66, color)

@tool

class_name Item
extends Button

const rarity_colors = {
	"common": Color(0.8, 0.8, 0.8),
	"rare": Color(0.4, 0.55, 1),
	"legendary": Color(1, 0.78, 0)
}

@export var item_name: String

@export var item_image: Texture2D

@export_multiline var item_description: String

@export_enum("common", "rare", "legendary") var item_rarity = "common"

@export var item_lifetime: int = 1

@export_category("Nodes")
@export var panel_container: PanelContainer
@export var name_label: Label
@export var texture_rect: TextureRect
@export var description_label: Label

var inventory_id: int #set by inventory. an int that gets incremented every time an item it's added

func _ready() -> void:
	
	var stylebox: StyleBoxFlat = panel_container.get_theme_stylebox("panel")
	var target_name_length = size.x - stylebox.content_margin_left - stylebox.content_margin_right - stylebox.border_width_left - stylebox.border_width_right
	var current_name_length = calculate_text_length(item_name, name_label)
	
	for i in 100:
		if current_name_length > target_name_length:
			name_label.add_theme_font_size_override("font_size", name_label.get_theme_font_size("font_size") - i)
			current_name_length = calculate_text_length(item_name, name_label)
		else:
			break
	
	name_label.text = item_name
	
	texture_rect.texture = item_image
	description_label.text = item_description
	
	var new_stylebox = panel_container.get_theme_stylebox("panel").duplicate()
	new_stylebox.border_color = rarity_colors[item_rarity]
	panel_container.add_theme_stylebox_override("panel", new_stylebox)
	
func calculate_text_length(text, label) -> float:
	return label.get_theme_font("font").get_string_size(text, label.horizontal_alignment, -1, label.get_theme_font_size("font_size")).x

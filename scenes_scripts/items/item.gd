@tool

class_name Item
extends Control

const rarity_colors = {
	"common": Color(0.8, 0.8, 0.8),
	"rare": Color(0.4, 0.55, 1),
	"legendary": Color(1, 0.78, 0)
}

@export var item_name: String

@export var item_image: Texture2D

@export_multiline var item_description: String

@export_enum("common", "rare", "legendary") var item_rarity = "common"

@export_category("Labels")
@export var name_label: Label
@export var texture_rect: TextureRect
@export var description_label: Label
@export var card_container: PanelContainer

func _ready() -> void:
	name_label.text = item_name
	texture_rect.texture = item_image
	description_label.text = item_description
	
	var new_stylebox = card_container.get_theme_stylebox("panel").duplicate()
	new_stylebox.border_color = rarity_colors[item_rarity]
	card_container.add_theme_stylebox_override("panel", new_stylebox)

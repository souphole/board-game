@tool

extends CenterContainer

@export var die_center_container: CenterContainer

@onready var hbox_container:= $HBoxContainer
	
func change_position(offset: float):
	position = die_center_container.position + Vector2(0, offset)

func change_panel_size(panel_size: int):
	for child in hbox_container.get_children():
		if child is PanelContainer:
			child.custom_minimum_size = Vector2(panel_size, 0)

class_name GUI
extends CanvasLayer

@onready var menu_manager: MenuManager = $MarginContainer/menu_manager

@export var items: Node #this is just for the dev menu

signal pressed_roll

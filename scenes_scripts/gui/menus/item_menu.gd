class_name ItemMenu
extends Control

@export var items_hbox: HBoxContainer
@export var animation: AnimationPlayer

func _ready() -> void:
	items_hbox.mouse_entered.connect(func(): animation.play("item_hover"))

class_name MenuManager
extends Control

## This works like the state machine but for switching between menus instead of the player actions

@export var gui: GUI

@export var start_menu: Menu

@export var animation: AnimationPlayer

var current_menu: Menu

var menu_hidden := false

#Initializes the menu machine by injecting dependencies and entering start_menu
func _ready() -> void:
	for child in get_children():
		
		if child is Menu:
		
			child.parent = self
			child.animation = animation
	
			child.visible = false
	
	change_menu(start_menu)
	
	current_menu.visible = true
	
#changes menu by calling exit() on old menu and enter() on new menu
func change_menu(new_menu: Menu) -> void:
	if current_menu != null:
		current_menu.exit()
	current_menu = new_menu
	current_menu.enter()

func hide_menu():
	if not menu_hidden:
		menu_hidden = true
		await current_menu.exit()
		current_menu.visible = false

func show_menu():
	if menu_hidden:
		menu_hidden = false
		await current_menu.enter()
		current_menu.visible = true

func _unhandled_input(event: InputEvent) -> void:
	var new_menu = current_menu.process_input(event)
	if new_menu != null:
		change_menu(new_menu)

func _process(delta: float) -> void:
	var new_menu = current_menu.process(delta)
	if new_menu != null:
		change_menu(new_menu)

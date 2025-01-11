class_name Menu
extends Control

@export var enter_animation_name: String = "default_enter"

@export var exit_animation_name: String = "default_exit"

@export var parent_menu: Menu

var parent: MenuManager
var animation: AnimationPlayer

var reference_menu: Menu

func enter() -> void:
	
	reference_menu = null
	
	for child in get_all_children(self):
	
		if child is DefaultButton:
			child.parent_menu = self
	
		if child is SwitcherButton: #SwitcherButton inherets DefaultButton, so it already has the parent_menu set
			child.connect("pressed", func(): reference_menu = child.menu)
	
	animation.queue(enter_animation_name)
	
	await animation.animation_started
	
	visible = true
	
	return
		
func exit() -> void:
	animation.queue(exit_animation_name)
	
	await animation.animation_changed
	
	visible = false
	
	return

func process_input(event: InputEvent) -> Menu:
	if Input.is_action_just_pressed("ui_cancel") && not animation.is_playing():
		
		return parent_menu #TODO add a pause menu
	
	return null
	
func process(delta: float) -> Menu:
	return reference_menu #null unless a SwitcherButton is pressed where it's changed to that button's submenu
	
#gets children recursively
func get_all_children(input_node: Node) -> Array:
	var children: Array
	
	for child in input_node.get_children():
		children.append(child)
	
		for recursive_child in get_all_children(child):
			children.append(recursive_child)
	
	return children

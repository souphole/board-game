class_name StateMachine
extends Node

# a lot of this code is just an implementation/rip of the state machine from this tutorial https://shaggydev.com/2023/10/08/godot-4-state-machines/
# this is a good guide you should read it if you dont know how this already works

@export var start_state: State
var current_state: State

#Initializes the state machine by giving each state the reference to the parent as well as entering start_state
func init(parent: Player) -> void:
	for child in get_children():
		child.parent = parent
	change_state(start_state)

#changes state by calling exit() on old state and enter() on new state
func change_state(new_state: State) -> void:
	if current_state != null:
		current_state.exit()
	current_state = new_state
	current_state.enter()

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state != null:
		change_state(new_state)

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state != null:
		change_state(new_state)
	
func process(delta: float) -> void:
	var new_state = current_state.process(delta)
	if new_state != null:
		change_state(new_state)

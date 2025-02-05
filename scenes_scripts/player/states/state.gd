class_name State
extends Node

@export var animation_name: String = "default"

var parent: Player

func init() -> void:
	pass
	
func enter() -> void:
	parent.sprite.play(animation_name)
	
func exit() -> void:
	pass
	
func process_input(event: InputEvent) -> State:
	return null
	
func process_physics(delta: float) -> State:
	return null
	
func process(delta: float) -> State:
	return null

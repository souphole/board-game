@icon("res://assets/diceicon.png")

class_name Die
extends Area2D

@export var enter_animation = "enter"
@export var exit_animation = "exit"

@export var time_between_value_switch: float = 0.1 #how fast the value is changed. jump time should be greater than this value though it doesnt really matter if its fast enough

var min: int = 1
var max: int = 10
var override: int = -1

var value: int = randi() % max + min

@onready var value_label: Label = $center/value
@onready var animation: AnimationPlayer = $animation

@onready var value_timer = Timer.new()

func _ready() -> void:
	change_value()
	
	#creates timer with the specified properties
	value_timer.wait_time = time_between_value_switch
	value_timer.connect("timeout", on_timeout)
	add_child(value_timer)
	value_timer.start()
	
#changes value and starts timer again
func on_timeout() -> void:
	change_value()
	value_timer.start()

#gets a new random value and changes the label to it
func change_value():
	value = new_random_value(value) #value in the exclude value since it looks weird to have repeating values
	value_label.text = str(value)

#creates an array with all values in range except the excluded integer, and then picks at random
func new_random_value(exclude: int = NAN):
	var value_array: Array
	
	if override >= 0:
		return override
	
	for i in range(min, max + 1):
		value_array.append(i)
		
	var filtered_array = value_array.filter(func(num): return num != exclude)
	
	return filtered_array.pick_random()

func enter() -> void:
	animation.play(enter_animation)
	await animation.animation_finished
	return

func exit() -> void:
	value_timer.stop()
	animation.play(exit_animation)
	await animation.animation_finished
	return

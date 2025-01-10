class_name HitLabel
extends CenterContainer

var value: int

@export var enter_animation = "enter"

@export var exit_animation = "exit"

@onready var animation: AnimationPlayer = $animation

@onready var label: Label = $label

func _ready() -> void:
	change_value(value)

func change_value(value: int):
	label.text = str(value)

func enter() -> void:
	animation.play(enter_animation)
	await animation.animation_finished
	return

func exit() -> void:
	animation.play(exit_animation)
	await animation.animation_finished
	return

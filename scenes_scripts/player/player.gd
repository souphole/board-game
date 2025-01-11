class_name Player
extends CharacterBody2D

#dev stuff. just toggle dev off
@export_category("Dev")
@export var dev: bool

#nodes that need to be set
@export_category("Nodes")
@export var gui: GUI
@export var path_container: PathContainer
@export var starting_space: Space

#gets some children nodes
@onready var sprite: AnimatedSprite2D = $sprite
@onready var dice_container: DiceContainer = $dice_container
@onready var state_machine = $state_machine

#defines current path and space
@onready var current_path = starting_space.get_parent()
@onready var current_space = starting_space

var spaces_to_move: int = 0

var path_index: int = 0 #used for getting the next space

var dice_mod: int

signal hit_die

func _ready() -> void:
	#initializes state machine and passes reference of the player to the state machine (state machine then passes this to the different states)
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process(delta)

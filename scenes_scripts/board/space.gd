@tool
class_name Space
extends Area2D

@export_category("Space")
@export_enum("default", "bad_test", "good_test", "default_item") var type = "default"

@export var branch_nodes: Array[Space]
var has_branch_nodes = false
@onready var Sprite = $sprite

var last_node = false

func _ready() -> void:
	#changes sprite to the defined type
	Sprite.animation = type
	
	#checks if its the last node in a path
	if get_index() == get_parent().get_child_count() - 1:
		last_node = true
		
	if branch_nodes.size() > 0:
		for i in len(branch_nodes):
			if branch_nodes[i] == null: #checks for any null values and removes them
				branch_nodes.remove_at(i)
		if branch_nodes.size() > 0 && not last_node: #after removing null values checks if the array is still greater than 0 
			has_branch_nodes = true
		elif branch_nodes.size() > 1: #this is if its the last node in a path, since having one branch node would just mean merging into another path
			has_branch_nodes = true

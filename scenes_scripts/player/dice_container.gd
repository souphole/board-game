@tool

class_name DiceContainer
extends Node2D

@export_group("Appearance Settings")
@export var hit_label_height_above_die: float = -120
@export var panel_size: int = 180
@export var preview_node: Control
@export var preview_hit_label_center_container: CenterContainer

@onready var hit_label = preload("res://scenes_scripts/gui/label/hit_label.tscn")

var tween: Tween

var active_die: Die

var final_sum: int

var final_hit_label: HitLabel

var finished := true #sets to false whenever spawn_dice() is called

signal active_die_entered

func _ready() -> void:
	if Engine.is_editor_hint():
		preview_hit_label_center_container.change_position(hit_label_height_above_die)
		preview_hit_label_center_container.change_panel_size(panel_size)
	else:
		preview_node.visible = false
		
func spawn_dice(parent: Player, dice_queue: Array, dice_mod: int = 0) -> void:
	
	finished = false
	
	var hit_label_positions = calculate_hit_label_positions(dice_queue, dice_mod).duplicate()
	var hit_values = []
	var hit_labels = []
	
	#adds hit_label if a dice_mod argument is passed
	if dice_mod != 0:
		
		hit_values.append(dice_mod)
		
		#creates a new label 
		var dice_mod_hit_label = add_hit_label(dice_mod)
		
		dice_mod_hit_label.enter()
		
		hit_labels.append(dice_mod_hit_label)
		
		#sets the hit_label to the first free position
		dice_mod_hit_label.position = hit_label_positions[0]
		hit_label_positions.pop_front()
	
	#goes through the dice_queue and creates a die with those properities. once that die is hit and label is in position, spawns next die
	for die in dice_queue:
		active_die = spawn_active_die(die)
		
		await active_die.enter()
		active_die_entered.emit()
		
		await parent.hit_die
		
		#add the die's current value to the hit_values array
		var hit_value = active_die.value
		hit_values.append(hit_value)
		
		#create a new hit_label with hit_value
		var new_hit_label = add_hit_label(hit_value)
		
		new_hit_label.enter()
		
		hit_labels.append(new_hit_label)
		
		await active_die.exit()
		remove_child(active_die)
		
		tween = create_tween()
		#tween the hit_label's position to the next hit_label_position
		tween.tween_property(new_hit_label, "position", hit_label_positions[0], 0.75).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		await tween.finished
		
		hit_label_positions.pop_front()
	
	
	if len(hit_labels) > 1:
		
		#tween all the hit labels to the center
		for label in hit_labels:
			tween = create_tween()
			tween.tween_property(label, "position", Vector2(0, hit_label_height_above_die), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
			label.exit()
		
		await tween.finished
	
		for label in hit_labels:
			remove_child(label)
		hit_labels.clear() #not necessary but IDK feels gross to leave it out
		
		final_sum = sum_array(hit_values)
		hit_values.clear() #ditto
		
		#check if the sum is less than zero. used since dice_mod might make the final sum a negative value.
		if final_sum < 0:
			final_sum = 0
		
		final_hit_label = add_hit_label(final_sum)
		
		final_hit_label.position = Vector2(0, hit_label_height_above_die)
		
		await final_hit_label.enter()
		
	else:
		
		final_hit_label = hit_labels[0]
	
	finished = true

func get_final_hit_label_value() -> int: #used for counting down every move
	return final_hit_label.value

func set_final_hit_label_value(value: int) -> void: #used for counting down every move
	if final_hit_label:
		final_hit_label.change_value(value)
	
func remove_final_hit_label() -> void:
	if final_hit_label != null:
		await final_hit_label.exit()
		remove_child(final_hit_label)
	
func calculate_hit_label_positions(dice_queue, dice_mod) -> Array:
	var label_positions = []
	var label_count = 0
	
	if dice_mod != 0:
		label_count = len(dice_queue) + 1
	else:	
		label_count = len(dice_queue) 
	
	
	for i in label_count:
		var x_value = (i * panel_size) - ( (label_count * panel_size) / 2 ) + (panel_size / 2) #(i * panel_size) - (half the size of all the panels side-by-side) + (half the size of a single panel)
		
		label_positions.append(Vector2(x_value, hit_label_height_above_die))
	
	return label_positions

func add_hit_label(num: int) -> HitLabel:
	var new_hit_label: HitLabel = hit_label.instantiate()
	new_hit_label.value = num
	add_child(new_hit_label)
	return new_hit_label

func spawn_active_die(new_die: Die):
	add_child(new_die)
	return new_die

func sum_array(array):
	var total = 0
	
	for element in array:
		total += element
	
	return total

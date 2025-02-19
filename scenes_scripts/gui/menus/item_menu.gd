class_name ItemMenu
extends Control

@export var hover_enter: Control
@export var hover_exit: Control
@export var items_hbox: HBoxContainer
@export var animation: AnimationPlayer

var hover = false

func _ready() -> void:
	
	hover_enter.mouse_entered.connect(func():
		if not hover:
			hover = true
			animation.queue("item_hover")
	)
	
	hover_exit.mouse_exited.connect(func():
		if hover:
			hover = false
			animation.queue("item_hover_exit")
	)
	
	inventory.inventory_changed.connect(update_items)
	
func update_items() -> void:
	var inventory_ids = inventory.inventory_dict.keys()
	
	var pending_ids = get_current_inventory_ids()
	
	for id in inventory_ids:
		if pending_ids.has(id):
			pending_ids.pop_at(pending_ids.find(id))
		else:
			var new_item = inventory.inventory_dict.get(id)
			items_hbox.add_child(new_item)
	
	for id in pending_ids:
		for child: Item in items_hbox.get_children():
			if child.inventory_id == id:
				items_hbox.remove_child(child)
	
func get_current_inventory_ids() -> Array:
	var inventory_ids: Array
	
	for item: Item in items_hbox.get_children():
		inventory_ids.push_back(item.inventory_id)
	
	return inventory_ids

class_name Inventory
extends Node

var inventory_dict: Dictionary #for items in the actual inventory

var used_items: Array[Item]

var hold: Array[Item] #for items on "hold" idk if this will be used for anything

var max_items := 5

var inventory_id := 0 #incremented every time an item is added

signal inventory_changed #should be emitted *any* time there is a change to the inventory

func add_item(item: Item):
	
	var new_item = item.duplicate(DUPLICATE_USE_INSTANTIATION)
	
	if len(inventory_dict) < max_items:
		new_item.inventory_id = inventory_id
		inventory_dict.get_or_add(inventory_id, new_item)
		inventory_changed.emit()
		
		inventory_id += 1
		
	else:
		hold.push_back(new_item)
		print("TODO add functions for items in hold! Current items in hold: " + str(hold))
	
func use_item(id: int):
	var used_item = inventory_dict.get(id)
	inventory_dict.erase(id)
	
	used_items.append(used_item)
	print("used items: ", used_items)
	inventory_changed.emit()
	
func drop_item(index: int):
	inventory_dict.erase(index)
	inventory_changed.emit()

func update_lifespans():
	for item in used_items:
		item.item_lifetime -= 1
		
	used_items = used_items.filter(func(item): return item.item_lifetime > 0)

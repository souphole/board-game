class_name Inventory
extends Node

var inventory_array: Array[Item] #for items in the actual inventory

var used_items: Array[Item]

var hold := [] #for items on "hold" i.e. they don't have room and a decision hasn't been made whether they should be discarded or not

var max_items := 3

signal inventory_changed #should be emitted *any* time there is a change to the inventory

func add_item(item: Item):
	if not len(inventory_array) >= max_items:
		inventory_array.push_back(item)
		inventory_changed.emit()
		
	else:
		hold.push_back(item)
		print("TODO add functions for items in hold! Current items in hold: " + str(hold))
	
func use_item(index: int):
	var used_item = inventory_array.pop_at(index)
	used_items.append(used_item)
	inventory_changed.emit()
	
func drop_item(index: int):
	inventory_array.pop_at(index)
	inventory_changed.emit()

func update_lifespans():
	for item_index in range(len(used_items)):
		var item = used_items[item_index]
		
		item.item_lifetime -= 1
		
		if item.item_lifetime <= 0:
			used_items.pop_at(item_index)

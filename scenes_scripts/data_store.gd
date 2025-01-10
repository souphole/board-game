class_name DataStore
extends Node

#holds data in one place so that multiple nodes can access it without needing to be directly communicating

var storage_dict: Dictionary

func store_data(key: String, data) -> void:
	storage_dict[key] = data

func get_data(key: String):
	return storage_dict.get(key)

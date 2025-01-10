@tool
class_name PathContainer
extends Node2D

#Name spaces 0, 1, 2... for the line drawing to work

func _ready() -> void:
	var space_containers = []
	for i in get_children():
		if i is SpaceContainer:
			space_containers.append(i)
	draw_line_paths(space_containers)
	var branches = get_branches(space_containers)
	draw_connections(branches)

#makes a new line and and adds a point for each space in a path
#repeats for all paths
func draw_line_paths(paths) -> void:
	for path in paths:
		var line = Line2D.new()
		line.z_index = -1
		for space in path.get_children():
			line.add_point(space.position + path.position)
		add_child(line)

#returns [space with a branch node, space it branches to]
func get_branches(paths) -> Array:
	var branches = []
	for path in paths:
		for space in path.get_children():
			if len(space.branch_nodes) > 0:
				for i in space.branch_nodes:
					branches.append([space, i])
	return branches

#draws connections between the branches
func draw_connections(branches) -> void:
	for branch in branches:
		var parent_path = branch[1].get_parent()
		var line_branch = Line2D.new()
		line_branch.z_index = -1
		line_branch.add_point(branch[0].position + branch[0].get_parent().position)
		line_branch.add_point(branch[1].position + parent_path.position)
		add_child(line_branch)

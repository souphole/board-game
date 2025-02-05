class_name ItemButton
extends DefaultButton

var item: Item

func _ready() -> void:
	
	super()
	
	if not item:
		disabled = true
		
func update_image() -> void:
	button_pressed = false
	
	if item:
		icon = item.item_image
		disabled = false
	else:
		icon = null
		disabled = true

class_name ItemButton
extends DefaultButton

var item: Item

func _ready() -> void:
	
	super()
	
	if not item:
		disabled = true
		print(disabled)

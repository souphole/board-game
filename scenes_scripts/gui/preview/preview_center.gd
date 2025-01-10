@tool
extends CenterContainer

func _ready():
	var texture_rect: TextureRect= $TextureRect
	var height = texture_rect.texture.get_height()
	position = Vector2(0, -(height/2 * scale.y))

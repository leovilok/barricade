extends Area2D


@export var max_hp = 6
@export var hp = 6

func _ready() -> void:
	hp = max_hp

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			get_viewport().set_input_as_handled()
			hp -= 1
			if hp <= max_hp/2.0:
				$Sprite.visible = false
			if hp <= 0:
				queue_free()

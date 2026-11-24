extends Area2D

@export var hp = 6
@export var content = 6

var bagscene = preload("res://sac_poubelle.tscn")



func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			
			if hp > 0:
				hp -= 1
			if hp <= 0 and content > 0:
				content -= 1
				$Sprite.visible = false
				$BrokenSprite.visible = true
				var bag = bagscene.instantiate()
				bag.position = position + Vector2(randi_range(-100,100), -100)
				bag.apply_central_impulse(Vector2(0, -500))
				get_parent().add_child(bag)
				bag.clicked.connect(get_parent()._on_pickable_clicked)

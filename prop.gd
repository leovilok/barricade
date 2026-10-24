extends RigidBody2D

signal clicked

var held = false

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			#print("clicked")
			clicked.emit(self)

func _physics_process(_delta):
	if held:
		global_transform.origin = get_global_mouse_position()

func pickup():
	if held:
		return
	freeze = true
	held = true
	collision_layer = 2

func drop(impulse=Vector2.ZERO):
	if held:
		freeze = false
		#linear_velocity = linear_velocity.clampf(-1000,1000)
		linear_velocity = Vector2.ZERO
		apply_central_impulse(impulse)
		held = false
		collision_layer = 1

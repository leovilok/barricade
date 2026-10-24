extends RigidBody2D

signal clicked

var mouse_held = false
var crs_pulled = false
var crs_held = false

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			#print("clicked")
			clicked.emit(self)

func _physics_process(_delta):
	if mouse_held:
		global_transform.origin = get_global_mouse_position()


func _on_body_entered(body: Node):
	if body.is_in_group("crs") and !mouse_held:
		body.call_deferred("get_hit", linear_velocity.length()*mass)

func pickup():
	if mouse_held or crs_pulled:
		return
	freeze = true
	mouse_held = true
	collision_layer = 2

func drop(impulse=Vector2.ZERO):
	if mouse_held:
		freeze = false
		#linear_velocity = linear_velocity.clampf(-1000,1000)
		linear_velocity = Vector2.ZERO
		apply_central_impulse(impulse)
		mouse_held = false
		collision_layer = 1

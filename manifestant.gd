extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Anim.play(["1","2","3"].pick_random())

func get_hit():
	apply_central_impulse(Vector2(40000, -20000))

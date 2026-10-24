extends CharacterBody2D

enum {STATE_RUN, STATE_FALL, STATE_PULL, STATE_HOLD}

const SPEED = 150
const RESISTANCE = 1000

@export var state = STATE_RUN

var prop = null

func _ready():
	$Anim.play("run")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	match state :
		STATE_RUN:
			velocity.x = SPEED
		STATE_FALL, STATE_PULL:
			velocity.x = 0
		STATE_HOLD:
			velocity.x = - SPEED/2.0
			prop.global_transform.origin = position + Vector2(-10, -50)
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collider = get_slide_collision(i).get_collider()
		if collider.is_in_group("prop") and state == STATE_RUN:
			prop = collider
			prop.freeze = true
			prop.crs_pulled = true
			prop.global_transform.origin = position + Vector2(100, 70)
			$Anim.speed_scale = 5.0/prop.mass
			$Anim.play("pull")
			state = STATE_PULL
		if collider.name == "leftbound":
			queue_free()
			if prop:
				prop.queue_free()


func get_hit(power):
		if state != STATE_FALL and power > RESISTANCE:
			#print(power)
			if prop != null:
				prop.freeze = false
				prop.crs_pulled = false
				prop.crs_held = false
				prop.collision_layer = 1
				prop = null
			$Anim.speed_scale = 1.0
			$Anim.play("fall")
			state = STATE_FALL


func _on_anim_animation_looped() -> void:
	match state:
		STATE_FALL:
			$Anim.play("run")
			state = STATE_RUN
		STATE_PULL:
			prop.crs_pulled = false
			prop.crs_held = true
			prop.collision_layer = 4
			collision_layer = 4
			collision_mask = 1 # 8 for invicibility while holding
			$Anim.play("hold")
			state = STATE_HOLD

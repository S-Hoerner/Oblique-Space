extends CharacterBody2D

@export var speed = 500
@export var rotation_speed = PI+(PI*1/3)

var rotation_direction = 0

func get_input():
	rotation_direction = Input.get_axis("ccw", "cw")
	velocity = transform.x * Input.get_axis("back", "forward") * speed

func _physics_process(delta):
	get_input()
	
	if Input.is_action_pressed("forward"):
		$linear_animated.play("forward")
	elif Input.is_action_pressed("back"):
		$linear_animated.play("back")
	elif Input.is_action_pressed("back") and Input.is_action_pressed("forward"):
		$linear_animated.stop()
	else:
		$linear_animated.stop()
	
	if Input.is_action_pressed("ccw"):
		$rotation_animated.play("ccw")
	elif Input.is_action_pressed("cw"):
		$rotation_animated.play("cw")
	elif Input.is_action_pressed("ccw") and Input.is_action_pressed("cw"):
		$rotation_animated.stop()
	else:
		$rotation_animated.stop()
	
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()

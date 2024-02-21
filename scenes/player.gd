extends CharacterBody2D

@export var speed = 500
@export var acceleration = 1
@export var rotation_speed = PI+(PI*1/3)
var linear_direction
var rotation_direction

func _physics_process(delta):
	get_direction()
	
	if Input.is_action_pressed("forward"):
		$linear_animated.play("forward")
		velocity = transform.y * move_toward(velocity.length(),speed,acceleration) * linear_direction
	elif Input.is_action_pressed("back"):
		$linear_animated.play("back")
		velocity = transform.y * move_toward(velocity.length(),speed,acceleration) * linear_direction
	elif Input.is_action_pressed("back") and Input.is_action_pressed("forward"):
		$linear_animated.stop()
	else:
		$linear_animated.stop()
	
	if Input.is_action_pressed("ccw"):
		$rotation_animated.play("ccw")
		rotation += rotation_direction * rotation_speed * delta
	elif Input.is_action_pressed("cw"):
		$rotation_animated.play("cw")
		rotation += rotation_direction * rotation_speed * delta
	elif Input.is_action_pressed("ccw") and Input.is_action_pressed("cw"):
		$rotation_animated.stop()
	else:
		$rotation_animated.stop()
	
	move_and_slide()

func get_direction():
	linear_direction = Input.get_axis("forward", "back")
	rotation_direction = Input.get_axis("ccw","cw")

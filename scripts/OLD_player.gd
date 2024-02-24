extends CharacterBody2D

@export var speed = 100
@export var acceleration = 0.075
@export var rotation_speed = PI
var linear_direction
var rotation_direction

func _physics_process(delta):
	get_direction()
	
	animatate()
	
	if Input.is_action_pressed("slow"):
		velocity += transform.y * linear_direction * (acceleration * (speed/4))
		rotation += rotation_direction * (rotation_speed/2) * delta
	elif Input.is_action_pressed("stop"):
		velocity.x = move_toward(velocity.x, 0, acceleration*(speed))
		velocity.y = move_toward(velocity.y, 0, acceleration*(speed))
	else:
		velocity += transform.y * linear_direction * (acceleration * speed)
		rotation += rotation_direction * rotation_speed * delta
	
	move_and_slide()

func animatate():
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
	elif Input.is_action_pressed("stop"):
		pass
	else:
		$rotation_animated.stop()
	
	if Input.is_action_pressed("stop"):
		$linear_animated.stop()
		$rotation_animated.stop()
		$stop_animated.show()
		$stop_animated.play("stop")
	else:
		$stop_animated.stop()
		$stop_animated.hide()

func get_direction():
	linear_direction = Input.get_axis("forward", "back")
	rotation_direction = Input.get_axis("ccw","cw")

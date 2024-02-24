extends RigidBody2D


@export var speed = 500
@export var acceleration = 0.075
@export var rotation_speed = 1000
var linear_direction
var rotation_direction
var applied_force

func _physics_process(delta):
	get_direction()
	
	animatate()
	
	applied_force = Vector2(0,speed).rotated(rotation)*linear_direction
	
	if Input.is_action_pressed("slow"):
		apply_central_force(applied_force/4)
		apply_torque(rotation_speed*rotation_direction/4)
		pass
	elif Input.is_action_pressed("stop"):
		#velocity.x = move_toward(velocity.x, 0, acceleration*(speed))
		#velocity.y = move_toward(velocity.y, 0, acceleration*(speed))
		pass
	else:
		apply_central_force(applied_force)
		apply_torque(rotation_speed*rotation_direction)
	
	#move_and_slide()

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
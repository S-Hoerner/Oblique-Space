extends CharacterBody2D

@export var speed = 400
@export var rotation_speed = PI

var rotation_direction = 0

func get_input():
	rotation_direction = Input.get_axis("ccw", "cw")
	velocity = transform.x * Input.get_axis("back", "forward") * speed

func _physics_process(delta):
	get_input()
	if Input.is_action_pressed("forward"):
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()

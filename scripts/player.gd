extends RigidBody2D

signal died
signal hit

@export var bullet_scene: PackedScene

@export var speed = 500
@export var acceleration = 0.075
@export var rotation_speed = 1000
@export var life = 1000000
@export var invinc_time = 0.1
var linear_direction
var rotation_direction
var applied_force
var dead
var invincible
var just_fired = false
var map_on = false
var can_play = true

func _ready():
	player_not_dead()
	$invincible_animated.hide()
	$map_animated.hide()
	$hit_sprite.hide()
	#$world_camera.enabled = false

func _physics_process(delta):
	if dead == false:
		if Input.is_action_just_released("map"):
			if map_on == true:
				can_play = false
				$map_animated.show()
				$map_animated.play("mapped")
				$world_camera.enabled = true
				$basic_camera.enabled = false
			elif map_on == false:
				can_play = true
				$map_animated.hide()
				$map_animated.stop()
				$world_camera.enabled = false
				$basic_camera.enabled = true
			map_on = !map_on
		
		if can_play == true:
			get_direction()
			
			animatate()
			
			applied_force = Vector2(0,speed).rotated(rotation)*linear_direction
			
			if Input.is_action_pressed("slow"):
				apply_central_force(applied_force/4)
				apply_torque(rotation_speed*rotation_direction/4)
				pass
			elif Input.is_action_just_pressed("stop"):
				sleeping = true
				sleeping = false
				pass
			else:
				apply_central_force(applied_force)
				apply_torque(rotation_speed*rotation_direction)
			if Input.is_action_pressed("attack") and $gun_timer.is_stopped():
				fire_gun()

func _on_body_entered(body):
	if invincible == false:
		if body.is_in_group("dangers"):
			life -= 1
			invincible = true
			emit_signal("hit")
		if life == 0:
			player_dead()

func player_dead():
	dead = true
	hide()
	#freeze = true
	sleeping = true
	$CollisionPolygon2D.set_deferred("disabled",true)
	emit_signal("died")

func player_not_dead():
	dead = false
	freeze = false
	sleeping = false
	invincible = false
	show()
	$CollisionPolygon2D.set_deferred("disabled",false)

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

func _on_hit():
	if invincible == true:
		$invincible_animated.show()
		$invincible_animated.play("invincible")
		$hit_sprite.show()
		await get_tree().create_timer(invinc_time).timeout
		$hit_sprite.hide()
		$invincible_animated.stop()
		$invincible_animated.hide()
		invincible = false

func fire_gun():
	var bullet = bullet_scene.instantiate()
	bullet.position = $bullet_spawn.position
	bullet.set_linear_velocity(get_linear_velocity())
	bullet.apply_impulse(Vector2(0,-speed*4).rotated(rotation))
	add_child(bullet)
	$gun_timer.start()

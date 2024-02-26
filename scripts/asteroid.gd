extends RigidBody2D

signal asteroid_destroyed

@export var life = 3

func _ready():
	select_asteroid()
	
	sleeping = false
	
	rotation = randf() * (2*PI)
	mass = (randi() % 25) + 1
	
	var rotation_direction = randi() % 3
	if rotation_direction == 2:
		rotation_direction = -1
	set_constant_torque((randi() % 1000)*mass*rotation_direction)
	

func _process(delta):
	pass

func hide_all():
	$collision_1.set_deferred("disabled", true)
	$collision_2.set_deferred("disabled", true)
	$collision_3.set_deferred("disabled", true)
	$collision_4.set_deferred("disabled", true)
	$collision_5.set_deferred("disabled", true)
	$collision_6.set_deferred("disabled", true)
	$collision_7.set_deferred("disabled", true)
	$collision_8.set_deferred("disabled", true)
	$sprite_1.hide()
	$sprite_2.hide()
	$sprite_3.hide()
	$sprite_4.hide()
	$sprite_5.hide()
	$sprite_6.hide()
	$sprite_7.hide()
	$sprite_8.hide()

func select_asteroid():
	hide_all()
	var selected_asteroid = randi() %8
	if selected_asteroid == 0:
		$sprite_1.show()
		$collision_1.set_deferred("disabled", false)
	elif selected_asteroid == 1:
		$sprite_2.show()
		$collision_2.set_deferred("disabled", false)
	elif selected_asteroid == 2:
		$sprite_3.show()
		$collision_3.set_deferred("disabled", false)
	elif selected_asteroid == 3:
		$sprite_4.show()
		$collision_4.set_deferred("disabled", false)
	elif selected_asteroid == 4:
		$sprite_5.show()
		$collision_5.set_deferred("disabled", false)
	elif selected_asteroid == 5:
		$sprite_6.show()
		$collision_6.set_deferred("disabled", false)
	elif selected_asteroid == 6:
		$sprite_7.show()
		$collision_7.set_deferred("disabled", false)
	elif selected_asteroid == 7:
		$sprite_8.show()
		$collision_8.set_deferred("disabled", false)
	else:
		pass

func _on_body_entered(body):
	if body.is_in_group("projectiles"):
		life -= 1
	if life == 0:
		asteroid_broken()

func asteroid_broken():
	sleeping = true
	hide_all()
	emit_signal("asteroid_destroyed")

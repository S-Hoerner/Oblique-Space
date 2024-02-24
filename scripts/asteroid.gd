extends RigidBody2D

func _ready():
	select_asteroid()
	
	rotation = randf() * (2*PI)
	mass = (randi() % 25) + 1
	
	var rotation_direction = randi() % 3
	if rotation_direction == 2:
		rotation_direction = -1
	set_constant_torque((randi() % 1000)*mass*rotation_direction)
	

func _process(delta):
	pass

func select_asteroid():
	$collision_1.disabled = true
	$collision_2.disabled = true
	$collision_3.disabled = true
	$collision_4.disabled = true
	$collision_5.disabled = true
	$collision_6.disabled = true
	$collision_7.disabled = true
	$collision_8.disabled = true
	$sprite_1.hide()
	$sprite_2.hide()
	$sprite_3.hide()
	$sprite_4.hide()
	$sprite_5.hide()
	$sprite_6.hide()
	$sprite_7.hide()
	$sprite_8.hide()
	
	var selected_asteroid = randi() %8
	if selected_asteroid == 0:
		$sprite_1.show()
		$collision_1.disabled = false
	elif selected_asteroid == 1:
		$sprite_2.show()
		$collision_2.disabled = false
	elif selected_asteroid == 2:
		$sprite_3.show()
		$collision_3.disabled = false
	elif selected_asteroid == 3:
		$sprite_4.show()
		$collision_4.disabled = false
	elif selected_asteroid == 4:
		$sprite_5.show()
		$collision_5.disabled = false
	elif selected_asteroid == 5:
		$sprite_6.show()
		$collision_6.disabled = false
	elif selected_asteroid == 6:
		$sprite_7.show()
		$collision_7.disabled = false
	elif selected_asteroid == 7:
		$sprite_8.show()
		$collision_8.disabled = false
	else:
		print("error")

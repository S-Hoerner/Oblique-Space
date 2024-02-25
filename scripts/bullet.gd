extends RigidBody2D

func _on_body_entered(body):
	hide()
	$CollisionPolygon2D.set_deferred("disabled",true)

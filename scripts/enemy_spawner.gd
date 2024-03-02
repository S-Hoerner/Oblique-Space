extends Path2D

@export var asteroid_scene: PackedScene 
@export var spawn_distance = 100

func _ready():
	pass

func _process(delta):
	pass

func spawn_enemy():
	var enemy = asteroid_scene.instantiate()
	
	var enemy_spawn_location = $enemy_spawner
	enemy_spawn_location.progress_ratio = randf()
	enemy.position = enemy_spawn_location.position
	enemy.position.x += randf() * spawn_distance * ((randi() % 3)-1)
	enemy.position.y += randf() * spawn_distance * ((randi() % 3)-1)
	
	add_child(enemy)

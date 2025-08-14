extends Node2D

@export var ingredient_scene: PackedScene
@export var spawn_delay = 3.0
@export var min_x = 50
@export var max_x = 750
@export var spawn_y = -770 # فوق الشاشة

func _ready():
	randomize()
	$SpawnTimer.wait_time = spawn_delay
	$SpawnTimer.start()

	
func _on_spawn_timer_timeout() -> void:
	var ingredient = ingredient_scene.instantiate()
	ingredient.position = Vector2(randf_range(min_x, max_x), spawn_y)
	get_parent().add_child(ingredient)

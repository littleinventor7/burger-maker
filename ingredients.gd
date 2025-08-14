extends Area2D

@export var minspeed = 10
@export var maxspeed = 20
var speed = 0
var ingredient_textures = []

func _ready():
	add_to_group("ingredient")
	
	ingredient_textures = [
		preload("res://images/lettuce.png"),
		preload("res://images/tomato.png"),
		preload("res://images/cheese.png"),
		preload("res://images/beef.png"),
		preload("res://images/sauce.png"),
		preload("res://images/onions.png"),
		preload("res://images/egg.png"),
	]
	speed = randf_range(minspeed, maxspeed)
	$Sprite2D.texture = ingredient_textures[randi() % ingredient_textures.size()]

func _physics_process(delta):
	position.y += speed * delta
	if position.y > 600:
		queue_free()

func _on_body_entered(body):
	if body.name == "player":
		body.add_ingredient($Sprite2D.texture)
		queue_free()

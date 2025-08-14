extends CharacterBody2D

@export var max_speed = 300
@export var acc = 1500
@export var friction = 1200

@onready var axis = Vector2.ZERO
var collected_ingredients = []  
var stack_height = -2   

func _ready():
	$GameTimer.start()
	

func add_ingredient(texture): 
	var new_ing = Sprite2D.new()
	new_ing.texture = texture
	new_ing.scale = Vector2(0.4, 0.4)
	new_ing.position = Vector2(140, 545 - stack_height)
	add_child(new_ing)
	stack_height += 20 
	collected_ingredients.append(texture)
#func _on_player_body_entered(body):
#	if body.is_in_group("ingredient"):
#		collected_ingredients.append(body.name)
#		body.queue_free()
		
#		print(collected_ingredients)

func _physics_process(delta):
	move(delta)

func get_input_axis():
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	return axis.normalized()
	
func move(delta):
	axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(friction * delta)
	else :
		apply_movement(axis * acc * delta)
	move_and_slide()
	
func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else :
		velocity = Vector2.ZERO
func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(max_speed)
	
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0


#func _physics_process(delta: float) -> void:
	# Add the gravity.
#	if not is_on_floor():
#		velocity += get_gravity() * delta

	# Handle jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction := Input.get_axis("move_left", "move_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)

#	move_and_slide()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://game_over.tscn")

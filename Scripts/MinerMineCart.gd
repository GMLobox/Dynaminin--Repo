extends CharacterBody2D

@onready var CAMERA := $Camera2D
@onready var S_RENAL := $Renald
@onready var S_CART := $Cart


const BASE_SPEED := 200.0
const JUMP_VELOCITY := -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var GROUNDED := is_on_floor()


func _physics_process(delta):
	GROUNDED = is_on_floor()

	
	if !GROUNDED:
		velocity.y += gravity * delta
	else:
		CAMERA.position.y = round(randf())


	if Input.is_action_just_released("Jump") && velocity.y < 0 && !GROUNDED:
		velocity.y = 0
	if Input.is_action_just_pressed("Jump") && GROUNDED:
		velocity.y = JUMP_VELOCITY

	if is_on_wall():
		queue_free()
	
	var direction := Input.get_axis("Slow", "Fast")
	if direction:
		velocity.x = move_toward(velocity.x, BASE_SPEED + (direction * 40), 10)
	else:
		velocity.x = move_toward(velocity.x, BASE_SPEED, 20.0)
	$Label.text = String.num(velocity.x, 2)

	move_and_slide()

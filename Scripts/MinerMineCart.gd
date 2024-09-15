extends CharacterBody2D

@export var CAMERA : Camera2D
@onready var S_RENAL := $Renald
@onready var S_CART := $Cart
@onready var Col := $Col

const dyna_scene := preload("res://Scenes/Objects/dynamite.tscn")
const col := [preload("res://Resources/renald_stand_col.tres"), preload("res://Resources/renald_duck_col.tres")]
var dyna = null

const BASE_SPEED := 200
const JUMP_VELOCITY := -400
var jump_buffer : int = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var GROUNDED := is_on_floor()


func _physics_process(delta) -> void:
	if Col.position != Vector2.ZERO && S_RENAL.animation == "Normal":
		Col.position = Vector2.ZERO
		Col.shape = col[0]
	GROUNDED = is_on_floor()

	
	if !GROUNDED:
		velocity.y += gravity * delta
	else:
		CAMERA.position.y = round(randf())
	CAMERA.position.x = position.x
	if Input.is_action_just_pressed("Jump"):
		jump_buffer = 8
	if Input.is_action_just_released("Jump") && velocity.y < 0 && !GROUNDED:
		velocity.y = 0
	if jump_buffer > 0:
		jump_buffer -= 1
		if GROUNDED:
			velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("Dynamite") && dyna == null:
		dyna = dyna_scene.instantiate()
		add_child(dyna)

	if is_on_wall():
		queue_free() #PLACEHOLDER!!1
	
	
	var direction := Input.get_axis("Slow", "Fast")
	if direction:
		velocity.x = move_toward(velocity.x, BASE_SPEED + (direction * 40), 10)
	else:
		velocity.x = move_toward(velocity.x, BASE_SPEED, 20.0)
	$Label.text = String.num(velocity.x, 2)
	
	anim_handle()


	move_and_slide()


func _child_leave_milk(node) -> void:
	if node.name == "Dynamite":
		dyna = null


func _screen_exit() -> void:
	if position.y > 0:
		queue_free()

func anim_handle() -> void:
	if GROUNDED:
		if Input.is_action_pressed("Drop"):
				S_RENAL.animation = "Crouch"
				S_RENAL.position = Vector2(0.5, -1.5)
				Col.position.y = 10
				Col.shape = col[1]
				return
		S_RENAL.position = Vector2(0, 0)
		S_RENAL.animation = "Normal"
		

extends AnimatableBody2D

var VSPD = -250
const HSPD = 200


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	position.x += delta * HSPD
	position.y += delta * VSPD
	
	VSPD += delta * 980
	if VSPD < -40 && Input.is_action_just_released("Dynamite"):
		print(VSPD)
		VSPD = 0

func _screen_exit():
	queue_free()


func _body_hit(body):
	if body.editor_description == "Obstacle":
		body.queue_free()
		Global.SCORE += 1000
		#add explosion scene here
		var exp = Global.add_scene("res://Scenes/Objects/ex_dyna.tscn")
		exp.position = position + get_parent().position
		queue_free()


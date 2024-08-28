extends AnimatableBody2D

var VSPD = -400
const HSPD = 600


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	position.x += delta * HSPD
	position.y += delta * VSPD
	
	VSPD += delta * 980

func _screen_exit():
	queue_free()


func _body_hit(body):
	if body.editor_description == "Obstacle":
		body.queue_free()
		Global.SCORE += 1000
		#add explosion scene here
		queue_free()

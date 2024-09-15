extends AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if frame == 5:
		queue_free()
	scale = Vector2.ONE + Vector2(frame * 0.25, frame * 0.25)

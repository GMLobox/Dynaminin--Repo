extends Node

var _time : float

func _process(delta):
	_time += delta

func _sinewave(range : float, speed : float):
	return sin(_time * speed) * range

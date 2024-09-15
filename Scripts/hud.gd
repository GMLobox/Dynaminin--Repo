extends CanvasLayer

@onready var LSCORE := $SCORE
@onready var LREST := $REST

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	LREST.text = "1UP 0" + String.num_int64(max(Global.HEALTH - 1, 0))
	LSCORE.text = "00" + String.num_int64(Global.SCORE)

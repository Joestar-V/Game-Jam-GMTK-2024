extends Path2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Top.progress_ratio += .001
	$Right.progress_ratio += .001
	$Bot.progress_ratio += .001
	$Left.progress_ratio += .001
	#$"Bot/Platform Left".global_rotation = 0
	#$"Bot/Platform Bottom".global_rotation = 0
	#$"Bot/Platform Right".global_rotation = 0
	#$"Bot/Platform Top".global_rotation = 0

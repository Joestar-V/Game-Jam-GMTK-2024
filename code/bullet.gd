extends Node2D

var targ
var death = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	global_position = global_position.move_toward(targ, 1.5)
	if(death):
		if(!$AudioStreamPlayer.playing && !$AudioStreamPlayer2.playing):
			queue_free()
func initialize(angles, target):
	rotation = angles
	targ = target
	

func _on_area_2d_body_entered(body):

	if body.get_name() == "Player":
		$"AudioStreamPlayer".play()
		global_position = Vector2(-100, -100)
		death = true

func _on_area_2d_area_entered(area):
	if area.get_name() == "Heart":
		area.get_parent().health -= 1
		$"AudioStreamPlayer2".play()
		global_position = Vector2(-100, -100)
		death = true

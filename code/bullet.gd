extends Node2D

var targ
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	global_position = global_position.move_toward(targ, 1.5)
	
func initialize(angles, target):
	rotation = angles
	targ = target
	

func _on_area_2d_body_entered(body):

	if body.get_name() == "Player":
		queue_free()


func _on_area_2d_area_entered(area):
	if area.get_name() == "Heart":
		area.get_parent().health -= 1
		global_position = Vector2(-100, -100)
		queue_free()

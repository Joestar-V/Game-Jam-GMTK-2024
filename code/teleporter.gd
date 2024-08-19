extends Node2D

@export var top = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.get_name() == "Player":
		if(top):
			body.global_position.y = get_viewport().get_visible_rect().size.y + 40
		else :
			body.global_position.y = -20

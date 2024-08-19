extends Node2D

@export var left = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.get_name() == "Player":
		if(left) :
			body.global_position.x = get_viewport().get_visible_rect().size.x + 16
			
		else :
			body.global_position.x = -16

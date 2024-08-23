extends Node2D

@export_file var destination
@export var one : Resource

@export var two : Resource

@export var three : Resource
# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	var my_random_number = rng.randi_range(1, 3)
	match my_random_number:
		1:
			$Sprite2D.texture = one
		2:
			$Sprite2D.texture = two
		3:
			$Sprite2D.texture = three


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("reset") :
		get_tree().change_scene_to_file(destination)
		

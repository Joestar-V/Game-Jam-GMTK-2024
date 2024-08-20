extends Node2D

@onready var health = 3
@export_file var destination
# Called when the node enters the scene tree for the first time.
func _ready():
	health = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(health <= 0):
		#$"../Spawner".queue_free()
		get_tree().change_scene_to_file(destination)

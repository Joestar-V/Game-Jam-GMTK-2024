extends Node2D

@onready var health = 3
@export_file var destination
@export var healthfull : Resource
@export var health1 : Resource
@export var health2 : Resource
# Called when the node enters the scene tree for the first time.
func _ready():
	health = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health == 3:
		$Sprite2D.texture = healthfull
	elif health == 2:
		$Sprite2D.texture = health1
	elif health == 1:
		$Sprite2D.texture = health2
	if(health <= 0):
		#$"../Spawner".queue_free()
		get_tree().change_scene_to_file(destination)

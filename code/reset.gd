extends Node2D

@onready var resetting = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(resetting) :
		get_tree().reload_current_scene()
		resetting = false

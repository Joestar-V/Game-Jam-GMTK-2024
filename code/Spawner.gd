extends Node2D

@export var mob_scene: PackedScene
@export var path1 : Node2D
@export var path2 : Node2D
@export var path3 : Node2D
@export var path4 : Node2D
var truepath
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var rng = RandomNumberGenerator.new()
	var my_random_number = rng.randi_range(1, 4)
	print(my_random_number)
	if(my_random_number == 1) :
		truepath = path1
	elif (my_random_number == 2) :
		truepath = path2
	elif (my_random_number == 3) :
		truepath = path3
	elif(my_random_number == 4) :
		truepath = path4
	
	
	var mob = mob_scene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = truepath
	# And give it a random offset.
	mob_spawn_location.progress_ratio = randf()
	#var direction = mob_spawn_location.rotation + PI / 2
	mob.global_position = mob_spawn_location.position
	#mob.rotation = direction
	mob._info(my_random_number)
	add_child(mob)

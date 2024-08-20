extends Node2D

@export var mob_scene: PackedScene
@export var mob_scene2: PackedScene
@export var mob_scene3: PackedScene
@export var mob_scene4: PackedScene
@export var path1 : Node2D
@export var path2 : Node2D
@export var path3 : Node2D
@export var path4 : Node2D
@export var roundAnnouncer : Node2D
@export var rounds = 3

@export var round1: Resource
@export var round2: Resource
@export var round3: Resource
@export var round4: Resource
@export var round5: Resource
@export var round6: Resource

@export var rapid = false
@export var freeze = false
@export var chaser = false

@export_file var destination
var truepath
var roundText = true
var wave = 1
var enemies = 0
var timer_running = false
var deaths = 0
var waiting = false
var roundtextpaused = true
@onready var currentRound = round1
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	timer_running = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(wave == rounds) :
		get_tree().change_scene_to_file(destination)
	#print(get_viewport().get_visible_rect().size)
	if(roundText) :
		roundAnnouncer.get_child(0).get_child(0).get_child(2).texture = currentRound
		if(roundAnnouncer.get_child(0).get_child(0).progress_ratio >= .5 and roundtextpaused) :
			$AnnounceTimer.start()
			roundText = false
		elif(roundAnnouncer.get_child(0).get_child(0).progress_ratio >= .98) :
			roundText = false
			roundAnnouncer.get_child(0).get_child(0).progress_ratio = 0
		else: 
			roundAnnouncer.get_child(0).get_child(0).progress_ratio += .01
		
	
	if(waiting) :
		return
	else :
		match wave :
			1: 
				currentRound = round1
				if timer_running:
					return
				else :
					if(enemies >= 6):
						if(deaths >= 6):
							deaths = 0
							wave += 1
							currentRound = round2
							var rng = RandomNumberGenerator.new()
							var my_random_number = rng.randf_range(1, 3)
							$RoundTimer.wait_time = my_random_number
							$RoundTimer.start()
							waiting = true
							roundText = true
							roundtextpaused = true
					else :
						
						var rng = RandomNumberGenerator.new()
						var my_random_number = rng.randf_range(.2, 2)
						$Timer.wait_time = my_random_number
						$Timer.start()
						timer_running = true
			2: 
				
				if timer_running:
					return
				else :
					if(enemies >= 7):
						if(deaths >= 7):
							deaths = 0
							wave += 1
							currentRound = round3
							var rng = RandomNumberGenerator.new()
							var my_random_number = rng.randf_range(1, 3)
							$RoundTimer.wait_time = my_random_number
							$RoundTimer.start()
							waiting = true
							roundText = true
							roundtextpaused = true
					else :
						var rng = RandomNumberGenerator.new()
						var my_random_number = rng.randf_range(.2, 2)
						$Timer.wait_time = my_random_number
						$Timer.start()
						timer_running = true
			3: 
				
				if timer_running:
					return
				else :
					if(enemies >= 8):
						if(deaths >= 8):
							deaths = 0
							wave += 1
							currentRound = round4
							var rng = RandomNumberGenerator.new()
							var my_random_number = rng.randf_range(1, 3)
							$RoundTimer.wait_time = my_random_number
							$RoundTimer.start()
							waiting = true
							#roundText = true
							#roundtextpaused = true
					else :
						var rng = RandomNumberGenerator.new()
						var my_random_number = rng.randf_range(.2, 2)
						$Timer.wait_time = my_random_number
						$Timer.start()
						timer_running = true
			4: 
				
				if timer_running:
					return
				else :
					if(enemies >= 9):
						if(deaths >= 9):
							deaths = 0
							wave += 1
							
							currentRound = round5
							var rng = RandomNumberGenerator.new()
							var my_random_number = rng.randf_range(1, 3)
							$RoundTimer.wait_time = my_random_number
							$RoundTimer.start()
							waiting = true
							#roundText = true
							#roundtextpaused = true
					else :
						var rng = RandomNumberGenerator.new()
						var my_random_number = rng.randf_range(.2, 2)
						$Timer.wait_time = my_random_number
						$Timer.start()
						timer_running = true
			5: 
				
				if timer_running:
					return
				else :
					if(enemies >= 10):
						if(deaths >= 10):
							deaths = 0
							wave += 1
							currentRound = round6
							var rng = RandomNumberGenerator.new()
							var my_random_number = rng.randf_range(1, 3)
							$RoundTimer.wait_time = my_random_number
							$RoundTimer.start()
							waiting = true
							#roundText = true
							#roundtextpaused = true
					else :
						var rng = RandomNumberGenerator.new()
						var my_random_number = rng.randf_range(.2, 2)
						$Timer.wait_time = my_random_number
						$Timer.start()
						timer_running = true
			6: 
				
				if timer_running:
					return
				else :
					if(enemies >= 11):
						if(deaths >= 11):
							deaths = 0
							wave += 1
							var rng = RandomNumberGenerator.new()
							var my_random_number = rng.randf_range(1, 3)
							$RoundTimer.wait_time = my_random_number
							$RoundTimer.start()
							waiting = true
							#roundText = true
							#roundtextpaused = true
					else :
						var rng = RandomNumberGenerator.new()
						var my_random_number = rng.randf_range(.2, 2)
						$Timer.wait_time = my_random_number
						$Timer.start()
						timer_running = true


func _on_timer_timeout():
	enemies += 1
	timer_running = false
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
	var mob
	if (freeze) :
		if (rapid) :
			if(chaser) :
				var random_enemy = rng.randi_range(1, 8)
				match random_enemy:
					1: 
						mob = mob_scene.instantiate()
					2:
						mob = mob_scene2.instantiate()
					3:
						mob = mob_scene3.instantiate()
					4:
						mob = mob_scene4.instantiate()
					_: 
						mob = mob_scene.instantiate()
			else : 
				var random_enemy = rng.randi_range(1, 6)
				match random_enemy:
					1: 
						mob = mob_scene.instantiate()
					2:
						mob = mob_scene2.instantiate()
					3:
						mob = mob_scene3.instantiate()
					_: 
						mob = mob_scene.instantiate()
						
		else : 
				var random_enemy = rng.randi_range(1, 4)
				match random_enemy:
					1: 
						mob = mob_scene.instantiate()
					2:
						mob = mob_scene3.instantiate()
					_: 
						mob = mob_scene.instantiate()
	else :
		mob = mob_scene.instantiate()

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


func _on_round_timer_timeout():
	waiting = false
	var rng = RandomNumberGenerator.new()
	var my_random_number = rng.randf_range(.2, 2)
	$Timer.wait_time = my_random_number
	$Timer.start()
	timer_running = true


func _on_announce_timer_timeout():
	roundText = true
	roundAnnouncer.get_child(0).get_child(0).progress_ratio += .01

	roundtextpaused = false

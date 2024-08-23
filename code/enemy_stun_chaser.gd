extends Node2D

@export var bullet: PackedScene

var phase = 0
var bullet_count = 0
var targetlocation : Vector2
var cooldown = true
var startpos: Vector2
var off = false
# Called when the node enters the scene tree for the first time.
func _ready():
	startpos = global_position
	pass # Replace with function body.
func _info(path) :
	var rng = RandomNumberGenerator.new()
	var my_random_number1 = rng.randf_range(0, 30)
	var my_random_number2 = rng.randf_range(0, 30)
	var randompos = Vector2(my_random_number1,my_random_number2)
	if(path == 1) :
		var newpos = randompos + Vector2(0,200)
		targetlocation = position + newpos
	elif (path == 2) :
		var newpos = randompos + Vector2(-200,0)
		targetlocation = position + newpos
	elif (path == 3) :
		var newpos = randompos + Vector2(0,-200)
		targetlocation = position + newpos
	elif (path == 4) :
		var newpos = randompos + Vector2(200,0)
		targetlocation = position + newpos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(off):
		return
	else :
		if(phase == 0) :
			global_position = global_position.move_toward(targetlocation, 2)
			if(global_position == targetlocation):
				phase = 1
		elif(phase == 1) :
			if(cooldown):
				cooldown = false
				$Timer.start()
			if(bullet_count > 1) :
				phase = 2
		elif(phase == 2):
			global_position = global_position.move_toward(startpos, 2)
			if(global_position == startpos):
				$"..".deaths += 1
				off = true
				queue_free
			

func _on_timer_timeout():
	cooldown = true
	
	bullet_count += 1
	if(bullet_count > 1) :
		phase == 2
	else:
		var targetPos = $"../../Player/Player".global_position
		var target = $"../../Player/Player"
		var angle = position.angle_to_point(targetPos)
		var shot = bullet.instantiate()
		shot.initialize(angle,target,get_tree().current_scene)
		shot.global_position = global_position
		get_node("/root").add_child(shot)
		$Timer.start()

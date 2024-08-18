extends Node2D

@export var bullet: PackedScene

var bullet_count = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _on_timer_timeout():
	bullet_count += 1
	if(bullet_count > 3) :
		pass
	else:
		var target = $"../Heart".position

		var angle = position.angle_to_point(target)
		var shot = bullet.instantiate()
		shot.initialize(angle,target)
		add_child(shot)
		$Timer.start

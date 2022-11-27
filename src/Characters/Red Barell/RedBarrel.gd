extends Character

func _process(delta):
#	var playerPosition : Vector3 = get_tree().get_root().find_node('Player', true, false).global_translation
#	var directionToPlayer := (playerPosition - global_translation).normalized()
#	res.direction = directionToPlayer
	res
	pass
	

func _physics_process(delta):
	res.velocity = res.direction * res.speed
	res.velocity = move_and_slide(res.velocity, Vector3.UP)
	self.apply_gravity()

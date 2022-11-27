extends Character

func _process(delta):
	
	res.direction = Vector3(
		(Input.get_action_strength("move_left") - Input.get_action_strength("move_right")),
		0.0,
		(Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward"))
	)
	
	
	if res.direction != Vector3.ZERO:
		res.velocity = lerp(res.velocity, res.direction * res.speed, res.accelerationRate)
	else:
		res.velocity = lerp(res.velocity, Vector3.ZERO, res.deccelerationRate)
	

func _physics_process(delta):
	res.velocity = move_and_slide(res.velocity)

extends Character

func _process(delta):
	
	res.direction = Vector3(
		(Input.get_action_strength("move_left") - Input.get_action_strength("move_right")),
		0.0,
		(Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward"))
	)
	
	

func _physics_process(delta):
	res.velocity.y = move_and_slide(res.velocity).y

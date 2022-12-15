extends Character

func _process(delta):
	set_direction()
	

func set_direction() -> void:
	
	follow_player()

func follow_player():
	var directionToPlayer = direction_to_player()
	
	res.direction = Vector3(directionToPlayer.x, set_y_direction(jump_states.WITHOUT_JUMP), directionToPlayer.z)
	

func direction_to_player() -> Vector3:
	var playerPosition : Vector3 = get_tree().get_root().find_node('Player', true, false).global_translation
	var directionToPlayer := (playerPosition - global_translation).normalized()
	
	
	return directionToPlayer

func calculate_velocity() -> void: 
	var delta := get_physics_process_delta_time()
	
	res.velocity = Vector3(
		lerp(
			res.velocity.x,
			clamp(res.direction.x * res.speed, -res.speed, res.speed),
			res.accelerationRate
		),
		res.velocity.y + res.direction.y * gravity,
		lerp(
			res.velocity.z,
			clamp(res.direction.z * res.speed, -res.speed, res.speed),
			res.accelerationRate
		)
	)
	
	
func _physics_process(delta):
	calculate_velocity()
	res.velocity = move_and_slide(res.velocity, Vector3.UP)
	self.apply_gravity()
	

extends KinematicBody
class_name Character

export var res : Resource
export var gravity : float = 98

func apply_gravity():
	res.direction.y = -1.0 if !is_on_floor() else 0.0
	res.velocity.y = gravity * res.direction.y * get_physics_process_delta_time()
	

extends KinematicBody
class_name Character

export var res : Resource
export var gravity : float = 98

"""
	This is enum for passing to func for setting y direction.
	It determines whether a character can jump or not.
"""
enum jump_states {WITH_JUMP, WITHOUT_JUMP} 

func apply_gravity():
	res.velocity.y += gravity * res.direction.y  
	

func set_direction() -> void:
	pass

func calculate_velocity() -> void:
	pass

func set_y_direction(_enum : int, isJumping : bool = false) -> float:
	var y_direction : float
	
	#For evaluating which conditions to apply based on a given enum
	if _enum == jump_states.WITH_JUMP: 
		if isJumping:
			y_direction = 1.0
		elif !is_on_floor():
			y_direction = -1.0
		else:
			y_direction = 0.0
	else:
		if !is_on_floor():
			y_direction = -1.0
		else:
			y_direction = 0.0
	
	return y_direction
	

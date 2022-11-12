extends Resource

export var speed : float
export var gravity : float
export var health : int

export var accelarationRate : float
export var deccelarationRate : float

var velocity := Vector3.ZERO 
var direction := Vector3.ZERO setget set_direction

func set_direction(_newDirection):
	set_velocity_from_direction(_newDirection)
	return _newDirection

func set_velocity_from_direction(_newDirection : Vector3):
	
	velocity.x = _newDirection.x * speed
	velocity.z = _newDirection.z * speed
	

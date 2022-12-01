extends Character


const MOUSE_SENSITIVITY = 0.05
const MAX_ROTATION_DEGREES = 60

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	set_direction()
	calculate_velocity()

func _input(event):
	
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if event is InputEventMouseMotion:
		rotation_degrees.y += -event.relative.x * MOUSE_SENSITIVITY
		$Camera.rotation_degrees.x += clamp(-event.relative.y * MOUSE_SENSITIVITY, -MAX_ROTATION_DEGREES, MAX_ROTATION_DEGREES)
		print($Camera.rotation_degrees.x)
		
	
	

func _physics_process(delta):
	res.velocity = move_and_slide(res.velocity, Vector3.UP)
	self.apply_gravity()
	

func set_direction():
	res.direction = Vector3(
		(Input.get_action_strength("move_left") - Input.get_action_strength("move_right")),
		set_y_direction(jump_states.WITH_JUMP, (Input.is_action_just_pressed("jump") and is_on_floor())),
		(Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward"))
	)
	

func calculate_velocity():
	if res.direction.x or res.direction.z != 0.0:
		res.velocity.x = lerp(res.velocity.x, res.direction.x * res.speed, res.accelerationRate)
		res.velocity.z = lerp(res.velocity.z, res.direction.z * res.speed, res.accelerationRate)
	else:
		res.velocity.x = lerp(res.velocity.x, 0.0, res.deccelerationRate)
		res.velocity.z = lerp(res.velocity.z, 0.0, res.deccelerationRate)

extends Character

var score := 0
onready var scoreText := $Camera/CanvasLayer/Control/ScoreText

var inputDirection : Vector3

const MOUSE_SENSITIVITY := 5.0
const MAX_ROTATION_DEGREES = 60

var toggleMouse := false

onready var collidingRay : RayCast = $Camera/RayCast


func _process(delta):
	
	set_inputDirection()
	set_direction()
	
	calculate_velocity()

func _input(event):
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	
	if Input.is_action_just_pressed("ui_cancel"):
		toggleMouse = !toggleMouse
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if toggleMouse else Input.MOUSE_MODE_CAPTURED)
	
	
	if event is InputEventMouseMotion:
		rotation_degrees.y += -event.relative.x * MOUSE_SENSITIVITY * get_process_delta_time()
		$Camera.rotation_degrees.x += -event.relative.y * MOUSE_SENSITIVITY * get_process_delta_time()
		$Camera.rotation_degrees.x = clamp($Camera.rotation_degrees.x, -MAX_ROTATION_DEGREES, MAX_ROTATION_DEGREES)
	

func _physics_process(delta):
	res.velocity = move_and_slide(res.velocity, Vector3.UP)
	self.apply_gravity()
	
func set_inputDirection():
	inputDirection = Vector3(
		(Input.get_action_strength("move_left") - Input.get_action_strength("move_right")),
		set_y_direction(jump_states.WITH_JUMP, Input.is_action_just_pressed("jump") && is_on_floor()),
		(Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward"))
	)

func set_direction():
	
	res.direction += inputDirection.x * transform.basis.x
	res.direction += inputDirection.z * transform.basis.z
	res.direction.y = inputDirection.y
	
	res.direction = res.direction.normalized()
	

func calculate_velocity():
	if inputDirection.x or inputDirection.z != 0.0:
		res.velocity.x = lerp(res.velocity.x, res.direction.x * res.speed, res.accelerationRate)
		res.velocity.z = lerp(res.velocity.z, res.direction.z * res.speed, res.accelerationRate)
	else:
		res.velocity.x = lerp(res.velocity.x, 0.0, res.deccelerationRate)
		res.velocity.z = lerp(res.velocity.z, 0.0, res.deccelerationRate)
	
func shoot():
	
	var barrel : Array = get_tree().get_nodes_in_group("Red Barrel")
	var collidedObject = collidingRay.get_collider()
	
	
	for i in barrel:
		if collidedObject == i:
			i.hurt()
			score += 10
			scoreText.text = "SCORE: " + str(score)


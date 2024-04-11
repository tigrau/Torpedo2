extends CharacterBody2D
class_name Torpedo

const SPEED = 350
const ROTATION_RAD = 0.01

var direction := Vector2.RIGHT
var lut_angle = 0
var angle = 0
var angle_memory = 0
var lut_flag = false
var SPEED2 = 170
var lut_right = true
var fat_flag = false
var fat_angle = 0
var fat_flag_right = true
var fat_flag2 = false
func _ready() -> void:
	if rotation:
		angle = rotation
		direction = direction.rotated(rotation)
	if $Timer.wait_time > 0.11:
		$Timer.start()

func _physics_process(delta: float) -> void:
	if $Timer.is_stopped():
		print($Timer.wait_time)
	if lut_flag:
		lut()
		velocity = SPEED * direction
	elif fat_flag:
		fat()
		velocity = SPEED * direction
	elif fat_flag2:
		fat2()
		velocity = SPEED * direction
	else:
		velocity = SPEED * direction

	rotation = velocity.angle()
	move_and_slide()
	$Node/Line2D.add_point(position)

func lut():
	if lut_right:
		lut_angle -= ROTATION_RAD
		#angle_memory += 0.03
		direction = direction.rotated(ROTATION_RAD)
		if lut_angle <= 0:
			lut_flag = false
			
	if not lut_right:
		lut_angle += ROTATION_RAD
		#angle_memory -= 0.03
		direction = direction.rotated(-ROTATION_RAD)
		if lut_angle >= 0:
			lut_flag = false



func set_lut(_lut_angle = 0):
	if _lut_angle:
		lut_flag = true
		lut_angle = deg_to_rad(_lut_angle)
		if lut_angle > 0:
			lut_right = true
		else:
			lut_right = false



func _on_timer_timeout() -> void:
	if fat_angle:
		print("fat_flag_true")
		fat_flag = true
	

func set_fat(_fat_ange = 0, _time = 0):
	if _fat_ange:
		if _time:
			$Timer.wait_time = _time
			print("timer_was_started")
		fat_angle = deg_to_rad(_fat_ange)
		print("fat_angle: " + str(fat_angle))
		if fat_angle > 0:
			fat_flag_right = true
		else:
			fat_flag_right = false

func fat():
	if fat_flag_right:
		fat_angle -= ROTATION_RAD
		angle_memory += ROTATION_RAD
		direction = direction.rotated(ROTATION_RAD)
		if fat_angle <= 0:
			fat_flag2 = true
			fat_flag = false
			fat_angle = PI/2 + PI/2
			angle_memory = 0
			#fat_flag = false
			#print(angle_memory)
			#fat_flag_right = !fat_flag_right
			#fat_angle = -angle_memory
			#angle_memory = 0
			#print(fat_angle)
			
	if not fat_flag_right:
		fat_angle += 0.03
		angle_memory -= ROTATION_RAD
		direction = direction.rotated(-ROTATION_RAD)
		if fat_angle >= 0:
			fat_flag2 = true
			fat_flag = false
			fat_angle = -PI/2 - PI/2
			angle_memory = 0
			#fat_flag = false
			#print(angle_memory)
			#fat_flag_right = !fat_flag_right
			#fat_angle = -angle_memory
			#angle_memory = 0
			#print(fat_angle)

func fat2():
	if fat_flag_right:
		fat_angle -= ROTATION_RAD
		angle_memory += ROTATION_RAD
		direction = direction.rotated(ROTATION_RAD)
		if fat_angle <= 0:
			#fat_flag = false
			print(angle_memory)
			fat_flag_right = !fat_flag_right
			fat_angle = -angle_memory
			angle_memory = 0
			print(fat_angle)
			
	if not fat_flag_right:
		fat_angle += ROTATION_RAD
		angle_memory -= ROTATION_RAD
		direction = direction.rotated(-ROTATION_RAD)
		if fat_angle >= 0:
			#fat_flag = false
			print(angle_memory)
			fat_flag_right = !fat_flag_right
			fat_angle = -angle_memory
			angle_memory = 0
			print(fat_angle)

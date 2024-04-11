extends CharacterBody2D


const SPEED = 300.0
var flag :bool = false
var flag2 :bool = false
var flag3 :bool = false

var flag_lut := true
var direction = 1
var angle = 0
var angle_memory = 0
var angle2 = deg_to_rad(30)
func _ready() -> void:
	$Timer.start()
	velocity = Vector2.RIGHT * SPEED
	angle = rotation
	print(rad_to_deg(rotation))
	velocity.x = sin(angle + angle2) * SPEED
	velocity.y = cos(angle + angle2) * SPEED
	
func _physics_process(delta: float) -> void:
	$Node/Line2D.add_point(position)
	if flag_lut:
		angle += 0.03
		velocity.y = sin(angle) * SPEED
		velocity.x = cos(angle) * SPEED
		rotation = velocity.angle()
		if angle >= angle + angle2:
			flag_lut = false
			angle = 0

	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	if flag:
		if flag2:
			angle -= 0.03
			if angle <= 0:
				flag2 = false
		else:
			angle += 0.03
		#print(rad_to_deg(angle))
		if abs(angle) >= PI:
			flag2 = true
			print("hi")
		rotation = velocity.angle()
		velocity.x = sin(angle + angle2) * SPEED
		velocity.y = cos(angle + angle2) * SPEED
		
		#if abs(angle) >= PI:
			#angle = 0
			#flag2 = true
		#angle += 0.1
		##if not flag2:
			##angle += 0.1
		##else:
			##angle -= 0.1
		#
		#if not flag2:
			#velocity.x = sin(angle) * SPEED
			#velocity.y = cos(angle) * SPEED
		#else:
			#velocity.y = sin(angle) * SPEED
			#velocity.x = cos(angle) * SPEED
	#velocity.rotated(deg_to_rad(30))
	move_and_slide()


func _on_timer_timeout() -> void:
	#direction = 0
	#velocity.x = 0
	#velocity.y = -300
	flag = true

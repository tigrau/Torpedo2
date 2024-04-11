extends CharacterBody2D

@export var torpedo_node : PackedScene

const SPEED = 200.0

func _ready() -> void:
	velocity = Vector2.UP * SPEED
func _physics_process(delta: float) -> void:
	var rotata = Input.get_axis("ui_left", "ui_right")
	if rotata:
		rotation += rotata * deg_to_rad(120) * delta
	var direction = Input.get_axis("ui_down","ui_up")
	if direction:
		velocity = Vector2.RIGHT * SPEED
		velocity = velocity.rotated(rotation)
	#else:
		#velocity = Vector2.ZERO
	move_and_slide()


func _on_button_pressed() -> void:
	var torpedo = torpedo_node.instantiate()
	torpedo.position = position
	torpedo.rotation = rotation
	if $CanvasLayer/HSlider.value:
		torpedo.set_lut($CanvasLayer/HSlider.value)
	if $CanvasLayer/HSlider3.value:
		torpedo.set_fat($CanvasLayer/HSlider3.value, $CanvasLayer/HSlider2.value)
		print("fat_was_set, timer time: " + str($CanvasLayer/HSlider2.value))

	get_tree().current_scene.add_child(torpedo)
	

func _on_h_slider_2_drag_ended(value_changed: bool) -> void:
	$CanvasLayer/Label2.text = "время: " + str($CanvasLayer/HSlider2.value)


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	$CanvasLayer/Label.text = "угол: " + str($CanvasLayer/HSlider.value)


func _on_h_slider_value_changed(value: float) -> void:
	$CanvasLayer/Label.text = "угол: " + str($CanvasLayer/HSlider.value)


func _on_h_slider_2_value_changed(value: float) -> void:
	$CanvasLayer/Label2.text = "время: " + str($CanvasLayer/HSlider2.value)


func _on_h_slider_3_value_changed(value: float) -> void:
	$CanvasLayer/Label3.text = "угол: " + str($CanvasLayer/HSlider3.value)

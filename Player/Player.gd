extends KinematicBody2D

export var max_speed := 250.0

export var acceleration := 775.0
export var friction := 800.0

export var jump_height := 150.0
export var jump_time_to_peak := 0.6
export var jump_time_to_descent := 0.4

onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var velocity := Vector2()

var jumping = false


func _physics_process(delta):
	#check for key_inputs
	velocity.y += get_gravity() * delta
	velocity.x = (Input.get_action_strength("right") - \
		Input.get_action_strength("left"))
	
	#calculate horizontal movement
	if velocity.x != 0:
		velocity.x = velocity.x * max_speed
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	check_for_landing()


func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity


func jump():
	velocity.y = jump_velocity
	
	Sound.play("player_jump", global_position)


func check_for_landing():
	var Ground_raycast = $Ground_raycast
	
	#When jumping and leaving the ground
	if !jumping and Ground_raycast.is_colliding():
		jumping = true
	
	#When landing and touching the ground
	elif jumping and Ground_raycast.is_colliding():
		jumping = false
		
		print("A")


func die():
	get_tree().reload_current_scene()

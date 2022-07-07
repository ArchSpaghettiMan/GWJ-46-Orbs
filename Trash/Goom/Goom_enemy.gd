extends KinematicBody2D

export var move_speed := 75.0
var velocity := Vector2()

var move_to = 0
onready var move_positions = $Positions.get_children()
export var move_lenience := 0.6


func _process(delta):
	var move_to = move_to()
	move(move_to, delta)


func move_to():
	if global_position.distance_to(move_positions[move_to].global_position)\
		 <= move_lenience:
		move_to += 1
		move_to = wrapi(move_to, 0, move_positions.size())
	
	return move_positions[move_to]


func move(move_to, delta):
	velocity = move_to.global_position - global_position
	velocity = velocity.normalized() * move_speed
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player"):
		body.die()

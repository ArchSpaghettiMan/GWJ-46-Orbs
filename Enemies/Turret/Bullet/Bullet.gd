extends KinematicBody2D

var speed := 250.0
var velocity := Vector2()
var max_distance := 200.0


func _physics_process(delta):
	velocity = velocity.normalized() * speed
	var collision = move_and_slide(velocity)
	
	if global_position.distance_to(get_parent().global_position) >= max_distance:
		queue_free()


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.die()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

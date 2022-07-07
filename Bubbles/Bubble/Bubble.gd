extends Node2D

var max_damage = 3
var damage = 0

onready var Bubble_manager = get_tree().get_nodes_in_group("Bubble_manager")[0]


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.jump()
		damage += 3
	
	elif body.is_in_group("Enemy"):
		body.queue_free()
		damage += 3
	
	elif body.is_in_group("Bullet"):
		body.queue_free()
		damage += 1
		
	if damage >= max_damage:
		queue_free()


func _on_Area2D_mouse_entered():
	Bubble_manager.delete_bubbles.append(self)


func _on_Area2D_mouse_exited():
	Bubble_manager.delete_bubbles.erase(self)

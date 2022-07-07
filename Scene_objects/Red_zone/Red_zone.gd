extends Node2D

onready var Bubble_manager = get_tree().get_nodes_in_group("Bubble_manager")[0]


func _on_Area2D_mouse_entered():
	Bubble_manager.can_place = false


func _on_Area2D_mouse_exited():
	Bubble_manager.can_place = true

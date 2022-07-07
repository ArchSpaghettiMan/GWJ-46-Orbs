extends Node

onready var Player = get_tree().get_nodes_in_group("Player")[0]


func _process(_delta):
	if Input.is_action_just_pressed("retry"):
		get_tree().reload_current_scene()
	elif Input.is_action_just_pressed("escape"):
		get_tree().quit()

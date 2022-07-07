extends Node2D

export (int, "Goal", "Scene_change") var mode
export var scene_destination: PackedScene


func _ready():
	$AnimationPlayer.play("float")


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		if mode == 0:
			get_tree().get_nodes_in_group("Level")[0].finish_level()
		else:
			get_tree().change_scene_to(scene_destination)

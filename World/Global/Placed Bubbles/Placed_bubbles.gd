extends Node2D

var Bubble_manager
var Level

export var Bubble_scene: PackedScene
var bubbles = []


func check_spawning():
	if bubbles != []:
		get_nodes()
		
		for i in bubbles:
			spawn_bubble(i)
		
		Level.max_bubbles -= bubbles.size()


func spawn_bubble(bubble_position):
	var Bubble = Bubble_scene.instance()
	Bubble.global_position = bubble_position
	Bubble_manager.add_child(Bubble)


func get_nodes():
	Bubble_manager = get_tree().get_nodes_in_group("Bubble_manager")[0]
	Level = get_tree().get_nodes_in_group("Level")[0]

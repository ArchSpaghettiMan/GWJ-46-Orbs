extends Node2D

export var bubble_scene : PackedScene

var max_bubbles = 1000
var bubbles = 0

var can_place = true

var delete_bubbles = []

onready var Level = get_tree().get_nodes_in_group("Level")[0]


func _process(_delta):
	if Input.is_action_just_pressed("left_click") and can_place:
		Sound.play("bubble_place", get_global_mouse_position())
		spawn_bubble()
		
		bubbles += 1
		
		if bubbles >= max_bubbles:
			can_place = false
		Level.update_bubble_count(max_bubbles - bubbles)
	
	elif Input.is_action_just_pressed("right_click"):
		for i in delete_bubbles:
			delete_bubbles.erase(i)
			i.queue_free()
			PlacedBubbles.bubbles.erase(i.global_position)
			
			bubbles -= 1
			
			can_place = true
			Level.update_bubble_count(max_bubbles - bubbles)


func spawn_bubble():
	var bubble = bubble_scene.instance()
	bubble.position = get_global_mouse_position()
	add_child(bubble)
	
	PlacedBubbles.bubbles.append(get_global_mouse_position())

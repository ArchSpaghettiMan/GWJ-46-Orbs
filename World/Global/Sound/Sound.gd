extends Node2D

export var Sound_player_scene: PackedScene


var sound_index = {
	"bubble_place": preload("res://Assets/Sounds/Bubble_place.wav"),
	"player_jump": preload("res://Assets/Sounds/Whoosh Sound Effects.wav")
}


func play(index, play_position):
	var Sound_player = Sound_player_scene.instance()
	
	Sound_player.stream = sound_index[index]
	add_child(Sound_player)
	
	Sound_player.play()

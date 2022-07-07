extends AudioStreamPlayer2D


func _on_Audio_player_finished():
	queue_free()

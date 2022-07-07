extends Node2D

onready var Play_camera = $Player/Cameras/Play_camera
onready var Pre_play_camera = $Player/Cameras/Pre_play_camera
var current_camera 

onready var Red_zones = $Scene_objects/Red_zones
onready var Bubble_manager = $Player/Bubble_manager

export var max_bubbles := 1

export var cam_speed := 10.0
var cam_velocity := Vector2()

export var cam_zoom = Vector2(0.1, 0.1)

export var next_level: PackedScene
export var next_menu := ""

enum modes {PRE_PLAY, PLAY}
var current_mode


func _ready():
	PlacedBubbles.check_spawning()
	Bubble_manager.max_bubbles = max_bubbles
	
	$Control/Level_stats/Bubble_count.text = "Max bubbles: " + \
		str(max_bubbles)
	
	change_to_mode(modes.PRE_PLAY)


func _process(_delta):
	#Changes into play mode, pause everything but pre-play cam and bubble manager
	if Input.is_action_just_pressed("play"):
		change_to_mode(modes.PLAY)
	
	#Moves and zooms camera while in pre-play mode
	else:
		cam_velocity.x = Input.get_action_strength("right") \
			- Input.get_action_strength("left")
		cam_velocity.y = Input.get_action_strength("down") \
			- Input.get_action_strength("up")
		cam_velocity = cam_velocity.normalized() * cam_speed
		
		Pre_play_camera.position += cam_velocity


func _unhandled_input(event):
	if current_mode == modes.PLAY:
		return
	
	#Changes Camera Zoom
	if event is InputEventMouseButton:
		if event.is_pressed():
			match event.button_index:
				BUTTON_WHEEL_DOWN:
					Pre_play_camera.zoom += cam_zoom
				BUTTON_WHEEL_UP:
					Pre_play_camera.zoom -= cam_zoom


func change_to_mode(mode):
	current_mode = mode
	
	#Stopping all nodes besides pre-play nodes
	if current_mode == modes.PRE_PLAY:
		$Player/Player/RemoteTransform2D.remote_path = \
			$Player/Cameras.Pre_play_camera.get_path()
		Play_camera.current = false
		Pre_play_camera.current = true
		
		for i in get_children():
			i.pause_mode = i.PAUSE_MODE_STOP
		get_tree().paused = true
		
		Pre_play_camera.pause_mode = Pre_play_camera.PAUSE_MODE_PROCESS
		Bubble_manager.pause_mode = Bubble_manager.PAUSE_MODE_PROCESS
		Red_zones.pause_mode = Red_zones.PAUSE_MODE_PROCESS
		
		current_camera = Pre_play_camera
	
	#Presum all nodes and hiding/deleting pre-play nodes
	elif current_mode == modes.PLAY:
		$Player/Player/RemoteTransform2D.remote_path = \
			$Player/Cameras.Play_camera.get_path()
		Pre_play_camera.current = false
		Play_camera.current = true
	
		Bubble_manager.can_place = false
		
		for i in $Control/Level_stats.get_children():
			i.queue_free()
		
		current_camera = Play_camera
		get_tree().paused = false


func update_bubble_count(amount):
	$Control/Level_stats/Bubble_count.text = "Max bubbles: " + \
		str(amount)


func finish_level():
	PlacedBubbles.bubbles.clear()
	
	if next_level != null:
		get_tree().change_scene_to(next_level)
	else:
		get_tree().change_scene(next_menu)

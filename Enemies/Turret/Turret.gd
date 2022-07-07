extends StaticBody2D

export var bullet_max_distance := 500.0

export var reload_time := 2.0

onready var reload_timer = $Reload_timer

export var bullet_scene : PackedScene

export var shoot_direction := Vector2(1,0)


func _ready():
	$Shoot_direction.set_cast_to(shoot_direction)
	reload_timer.wait_time = reload_time


func _process(_delta):
	if reload_timer.time_left == 0.0:
		reload_timer.start()


func _on_Reload_timer_timeout():
	var bullet = bullet_scene.instance()
	
	bullet.max_distance = bullet_max_distance
	bullet.velocity = $Shoot_direction.cast_to.normalized()
	
	add_child(bullet)

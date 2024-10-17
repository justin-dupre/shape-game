extends Node2D

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	var rand = randf()
	var mob_color
	if rand > 0.5:
		mob_color = Constants.COLORS.RED
	else:
		mob_color = Constants.COLORS.GREEN
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	new_mob.init(mob_color)
	add_child(new_mob)


func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true

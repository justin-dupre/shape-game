extends StaticBody2D

@onready var hitbox: Area2D = %Hitbox
@onready var collision_shape_2d: CollisionShape2D = $Hitbox/CollisionShape2D
@onready var bomb_sprite: Sprite2D = $BombSprite

var extra_explosions = 2
var hitboxes = []

func init(p_position: Vector2):
	global_position = p_position + Vector2(0, -200)
	%AnimationPlayer.queue("wiggle")
	
func _ready():
	hitboxes.push_back(hitbox)

func _on_timer_timeout() -> void:
	bomb_sprite.visible = false
	var enemies = hitbox.get_overlapping_bodies()
	_hit_targets_in_hitbox(hitbox)
	var direction = _get_explosion_direction()
			
	if extra_explosions > 0:
		for i in range(extra_explosions):
			var duplicate_hitbox = hitbox.duplicate()
			hitboxes.push_back(duplicate_hitbox)
			add_child(duplicate_hitbox)
			duplicate_hitbox.global_position = global_position + direction * (i + 1) * 200
			await Utils.wait(0.25)

			_hit_targets_in_hitbox(duplicate_hitbox)
			duplicate_hitbox.queue_free()
			if i + 1 == extra_explosions:
				queue_free()
			
	else:
		queue_free()

	
func _get_explosion_direction():
	# Get the right joystick axis values
	var direction = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")

	# If the vector's length is greater than zero, normalize it
	if direction.length() > 0:
		direction = direction.normalized()
	else:
		direction = get_mouse_direction()
		
	return direction
	
func get_mouse_direction():
	var mouse_position = get_viewport().get_mouse_position()
	var object_position = global_position
	var direction = (mouse_position - object_position).normalized()
	return direction  
	

func _draw():
	for hb in hitboxes:
		print(hb)
		#var shape = hb.shape
		#if shape is CircleShape2D:
			#var radius = shape.radius
			#draw_circle(Vector2.ZERO, radius, Constants.RED, false, 2)
		
func _hit_targets_in_hitbox(p_hitbox: Area2D):
	var enemies = p_hitbox.get_overlapping_bodies()
	for i in enemies.size():
		var curr_enemy = enemies[i]
		if curr_enemy.has_method("take_damage"):
			curr_enemy.take_damage(3)
	const SMOKE_EXPLOSION = preload("res://smoke_explosion/smoke_explosion.tscn")
	var smoke = SMOKE_EXPLOSION.instantiate()
	get_parent().add_child(smoke)
	smoke.global_position = p_hitbox.global_position

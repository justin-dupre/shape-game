extends CharacterBody2D
class_name Player

signal health_depleted

var health = 50000
const DAMAGE_RATE = 5.0
var bullets = []
var can_use_item = true
var bomb_upgrade = true

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
		
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	self.health -= DAMAGE_RATE * overlapping_mobs.size() * delta
	%HealthBar.value = self.health

	if self.health <= 0:
		health_depleted.emit()
		
	if Input.is_action_pressed("use_item"):
		place_square()
		
func place_square():
	if self.can_use_item:
		self.can_use_item = false
		const BOMB = preload("res://bomb.tscn")
		var new_bomb = BOMB.instantiate()
		get_parent().add_child(new_bomb)
		new_bomb.init(global_position)
		get_tree().create_timer(3).timeout.connect(func(): self.can_use_item = true)

		
func _ready():
	add_bullet_to_player()
	add_bullet_to_player()
	add_bullet_to_player()
	add_bullet_to_player()

	#GameManager.connect("player_upgraded", add_upgrade)

func add_bullet_to_player():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	
	if bullets.size() >= 1:
		## Not an anchor
		new_bullet.init(bullets.size(), bullets.size() + 1, bullets[0], false, Constants.COLORS.RED)
	else:
		## An anchor bullet is being created!!!!
		new_bullet.init(0, 0, new_bullet, true, Constants.COLORS.RED)

	bullets.push_back(new_bullet)
	add_child(new_bullet)
	
	
	## Update values on the bullets so that they can reset their target rotations
	for index in self.bullets.size():
		var current_bullet = bullets[index]
		if current_bullet.is_anchor_bullet:
			pass
		else:
			current_bullet.num_bullets = bullets.size()
			current_bullet.bullet_index = index


func add_upgrade(p_upgrade: Dictionary):
	match p_upgrade.keys()[0]:
		'BULLET':
			add_bullet_to_player()

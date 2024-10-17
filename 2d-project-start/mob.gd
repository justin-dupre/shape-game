extends CharacterBody2D

var health = 6
var color = Constants.COLORS.RED

@onready var player = get_node("/root/Game/Player")
func _ready() -> void:
	%Slime.play_walk()
	
func init(p_color: int):
	self.color = p_color
	%Slime.color = p_color
	

func _physics_process(delta: float):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()
	
func take_damage(p_amt: int = 1):
	self.health -= p_amt
	%Slime.play_hurt()
	if self.health <= 0:
		queue_free()
		drop_coin()
		GameManager.increment_score(1)
		
func drop_coin():
	const COIN = preload("res://coin.tscn")
	var new_coin = COIN.instantiate()
	get_parent().add_child(new_coin)
	new_coin.init(global_position)
	
func create_smoke():
	const SMOKE_EXPLOSION = preload("res://smoke_explosion/smoke_explosion.tscn")
	var smoke = SMOKE_EXPLOSION.instantiate()
	get_parent().add_child(smoke)
	smoke.global_position = global_position

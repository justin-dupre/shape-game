extends Area2D
class_name Bullet

@onready var sprite: Sprite2D = %Sprite


const BASE_ROTATION_DURATION = 2

var is_anchor_bullet = false
var anchor_bullet: Bullet
var num_bullets: int = 0
var bullet_index: int
var lerp_target_rotation: float
var color = Constants.COLORS.RED

func _ready():
	set_bullet_type()
	
func init(p_index: int, p_num_bullets: int, p_anchor_bullet: Bullet, p_is_anchor: bool, p_color: int):
	self.bullet_index = p_index
	self.is_anchor_bullet = p_is_anchor
	self.num_bullets = p_num_bullets
	self.color = p_color
	
	if !is_anchor_bullet:
		self.anchor_bullet = p_anchor_bullet
		
		var anchor_rotation = anchor_bullet.rotation
		var angle_per_bullet = TAU / num_bullets
		rotation = anchor_rotation + bullet_index * angle_per_bullet
	else:
		start_anchor_rotation()
		
func set_bullet_type():
	match self.color:
		Constants.COLORS.GREEN:
			sprite.texture = load("res://assets/green_body_circle.png")
		Constants.COLORS.RED:
			sprite.texture = load("res://assets/red_body_circle.png")

	
	
## ONLY USED FOR ANCHOR BULLET
## An anchor bullet is the bullet that all other bullets use to calculate their rotational values
func start_anchor_rotation():
	var tween = create_tween().set_loops()
	tween.tween_property(self, "rotation", TAU,  BASE_ROTATION_DURATION)
	tween.tween_callback(reset_anchor_rotation)
	
func reset_anchor_rotation():
	rotation = 0
	

func _on_body_entered(body: Node2D) -> void:
	#if body.has_method("take_damage") and body.get("color") == color:
	if body.has_method("take_damage"):
		body.take_damage()

func _process(delta: float) -> void:
	if !is_anchor_bullet:
		var anchor_rotation = anchor_bullet.rotation
		var angle_per_bullet = TAU / num_bullets
		rotation = anchor_rotation + bullet_index * angle_per_bullet

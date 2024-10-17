extends Node2D
@onready var slime_body: Sprite2D = $Anchor/SlimeBody

var color = Constants.COLORS.RED
func _ready():
	match color:
		Constants.COLORS.GREEN:
			slime_body.texture = load("res://assets/green_body_circle.png")
		Constants.COLORS.RED:
			slime_body.texture = load("res://assets/red_body_circle.png")

func play_walk():
	%AnimationPlayer.play("walk")


func play_hurt():
	%AnimationPlayer.play("hurt")
	%AnimationPlayer.queue("walk")

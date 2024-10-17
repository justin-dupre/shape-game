extends StaticBody2D

@onready var pickup_box: Area2D = %PickupBox

func init(p_position: Vector2):
	global_position = p_position
	pass
	

func _on_pickup_box_body_entered(body: Node2D) -> void:
	if body is Player:
		GameManager.add_coins(1)
		queue_free()

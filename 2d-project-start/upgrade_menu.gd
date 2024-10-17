extends MarginContainer

func _ready():
	GameManager.connect("upgrade_available", upgrade_available)
	
func upgrade_available(options: Array):
	get_tree().paused = true
	visible = true
	

func _on_add_bullet_pressed() -> void:
	GameManager.player_upgraded.emit({'BULLET': 'RED'})
	get_tree().paused = false
	visible = false

func _on_add_trap_pressed() -> void:
	GameManager.player_upgraded.emit({'TRAP': 'RED'})
	get_tree().paused = false
	visible = false

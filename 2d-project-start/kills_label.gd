extends Label

func _ready():
	GameManager.connect("coins_changed", update_coins)

func update_coins(amt: int):
	text = str(amt)
	

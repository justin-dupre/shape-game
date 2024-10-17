extends Label

func _ready():
	GameManager.connect("coin_changed", coin_changed)


func coin_changed(amt: int):
	text = str(amt)
	

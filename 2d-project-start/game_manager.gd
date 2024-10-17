extends Node

var score: int = 0
var coins: int = 0
var upgrade_index = -1


signal score_changed
signal coin_changed
signal player_upgraded
signal upgrade_available

var upgrade_dict = [
	{'BULLET': 'GREEN'},
	{'BULLET': 'GREEN'}
]

func add_coins(amt: int):
	coins += amt
	coin_changed.emit(coins)
	
func increment_score(amt: int):
	score += amt
	score_changed.emit(score)

	#if score == 4:
		#upgrade_index +=1
		#upgrade_available.emit([{'BULLET': 'GREEN'}, {'TRAP': 'RED'}])

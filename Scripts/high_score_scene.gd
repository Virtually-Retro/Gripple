extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$LabelScore.text = " " + str(Game_Globals.high_score)
	$LabelMoves.text = " " + str(Game_Globals.fewest_moves)
	$LabelTime.text = " " + str(Game_Globals.best_time)
	
	match Game_Globals.high_score_type:
		1:
			$LabelScore.text += "   Easy"
		2:
			$LabelScore.text += "   Medium"
		3:
			$LabelScore.text += "   Hard"

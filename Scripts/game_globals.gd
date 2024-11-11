#----------------------------------------------------
# Gripple by RYN for Godot 4.3.
# Globals Script
#----------------------------------------------------
extends Node

#Audio / Tutorial switch
var audio_enabled: bool = true
var tutorial_enabled: bool = true

#High score Table
var high_score: int = 0
var best_time: int = 1000
var fewest_moves: int = 1000
var high_score_type: int = 0

#Difficulity flag
var game_difficulty: int = 2

#Current Game Scores
var current_game_move_count: int = 0
var current_game_time: int = 0
var current_game_timer_bonus: int = 100
var current_game_score: int = 0

#Achievement flag
var achievement_type: int = 0


func _ready() -> void:
	load_gamedata()


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_gamedata()
		get_tree().quit() # default behavior


func save_gamedata() -> void:
	var file_data: String
	
	file_data = XmlTools.add_new_xml_key("audio_enabled", str(audio_enabled), file_data)
	file_data = XmlTools.add_new_xml_key("tutorial_enabled", str(tutorial_enabled), file_data)
	file_data = XmlTools.add_new_xml_key("high_score", str(high_score), file_data)
	file_data = XmlTools.add_new_xml_key("best_time", str(best_time), file_data)
	file_data = XmlTools.add_new_xml_key("fewest_moves", str(fewest_moves), file_data)
	file_data = XmlTools.add_new_xml_key("high_score_type", str(high_score_type), file_data)
	file_data = XmlTools.add_new_xml_key("game_difficulty", str(game_difficulty), file_data)
	
	var file: Object = FileAccess.open("user://gripple.dat", FileAccess.WRITE)
	file.store_string(file_data)
	file.close()
	
	
func load_gamedata() -> void:
	var file: Object = FileAccess.open("user://gripple.dat", FileAccess.READ)
	
	if file == null: #File not found
		return
			
	var file_data: String = file.get_as_text() #Read the entire files
	file.close()
	
	if file_data.is_empty(): #File Contains no data
		return
	else:
		#This is where we pass the save file
		#only process the high score table if a high score has been saved
		high_score = XmlTools.get_xml_key_data("high_score", file_data).to_int()
		if high_score > 0:
			#Process the remaining high score table
			best_time = XmlTools.get_xml_key_data("best_time", file_data).to_int()
			fewest_moves = XmlTools.get_xml_key_data("fewest_moves", file_data).to_int()
			high_score_type = XmlTools.get_xml_key_data("high_score_type", file_data).to_int()

		game_difficulty = XmlTools.get_xml_key_data("game_difficulty", file_data).to_int()
		if game_difficulty < 1:
			game_difficulty = 1
				
		audio_enabled = true
		if XmlTools.get_xml_key_data("audio_enabled", file_data) == "false":
			audio_enabled = false
			
		tutorial_enabled = true
		if XmlTools.get_xml_key_data("tutorial_enabled", file_data) == "false":
			tutorial_enabled = false
		

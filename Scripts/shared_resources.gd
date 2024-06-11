extends Node2D

@onready var click_sound: AudioStreamPlayer = $ClickSound

func play_audio(audio_id: int) -> void:
	if Game_Globals.audio_enabled == false:
		return
		
	match audio_id:
		0:
			click_sound.play()

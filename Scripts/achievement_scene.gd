extends Node2D

@onready var achievement_banner: Sprite2D = $AchievementBanner
@onready var achievement_sound: AudioStreamPlayer = $AchievementSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match Game_Globals.achievement_type:
		2:
			achievement_banner.texture = load("res://Graphics/Achievement_Fewest_moves.png")
		3:
			achievement_banner.texture = load("res://Graphics/Achievement_Best_Time.png")

	if Game_Globals.audio_enabled:
		achievement_sound.play()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/winner_scene.tscn")

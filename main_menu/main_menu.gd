extends Control

@onready var settings: Control = %Settings
@onready var credits: Control = %Credits
@onready var tutorial: Control = %Tutorial


func _ready() -> void:
	GameService.started.connect(_on_started)
	settings.visible = false
	credits.visible = false
	tutorial.visible = false


func _on_start_pressed() -> void:
	tutorial.visible = true


func _on_started():
	visible = false


func _on_settings_pressed() -> void:
	settings.visible = true


func _on_close_settings_pressed() -> void:
	settings.visible = false


func _on_credits_pressed() -> void:
	credits.visible = true


func _on_close_credits_pressed() -> void:
	credits.visible = false


func _on_master_audio_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))


func _on_begin_pressed() -> void:
	tutorial.visible = false
	GameService.start()


func _on_music_audio_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))


func _on_sfx_audio_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound Effects"), linear_to_db(value))

extends VBoxContainer

@onready var master: HSlider = %MasterAudioVolume
@onready var music: HSlider = %MusicAudioVolume
@onready var sfx: HSlider = %SFXAudioVolume


func _ready() -> void:
	AudioService.volume_changed.connect(_on_volume_changed)


func _on_master_audio_volume_value_changed(value: float) -> void:
	AudioService.set_volume("Master", value)


func _on_music_audio_volume_value_changed(value: float) -> void:
	AudioService.set_volume("Music", value)


func _on_sfx_audio_volume_value_changed(value: float) -> void:
	AudioService.set_volume("Sound Effects", value)


func _on_volume_changed(bus: String, value: float):
	match bus:
		"Master":
			master.value = value
		"Music":
			music.value = value
		"Sound Effects":
			sfx.value = value

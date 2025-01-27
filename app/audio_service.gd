extends Node

signal volume_changed(bus: String, value: float)

@onready var game_music: AudioStreamPlayer = %GameMusic
@onready var game_start_sfx: AudioStreamPlayer = %GameStartSFX
@onready var button_select: AudioStreamPlayer = %ButtonSelect
@onready var write_decision: AudioStreamPlayer = %WriteDecision
@onready var change_decision: AudioStreamPlayer = %ChangeDecision
@onready var bond_broken: AudioStreamPlayer = %BondBroken
@onready var bearer_died: AudioStreamPlayer = %BearerDied
@onready var victory: AudioStreamPlayer = %Victory

var _bus_values = {}


func _on_change_decision_finished() -> void:
	AudioService.write_decision.play()


func _on_button_select_finished() -> void:
	AudioService.change_decision.play()


func set_volume(bus: String, value: float):
	var index = AudioServer.get_bus_index(bus)
	var volumne = linear_to_db(value)

	AudioServer.set_bus_volume_db(index, volumne)

	_bus_values[bus] = value

	volume_changed.emit(bus, value)


func get_volume(bus: String) -> float:
	if _bus_values.has(bus):
		return _bus_values[bus]

	return 1.0

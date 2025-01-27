extends Node

@onready var game_music: AudioStreamPlayer = %GameMusic
@onready var game_start_sfx: AudioStreamPlayer = %GameStartSFX
@onready var button_select: AudioStreamPlayer = %ButtonSelect
@onready var write_decision: AudioStreamPlayer = %WriteDecision
@onready var change_decision: AudioStreamPlayer = %ChangeDecision
@onready var bond_broken: AudioStreamPlayer = %BondBroken
@onready var bearer_died: AudioStreamPlayer = %BearerDied
@onready var victory: AudioStreamPlayer = %Victory


func _on_change_decision_finished() -> void:
	AudioService.write_decision.play()


func _on_button_select_finished() -> void:
	AudioService.change_decision.play()

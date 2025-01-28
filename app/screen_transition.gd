extends Control

@onready var fade: ColorRect = %Fade
@onready var player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	GameService.transition_screen.connect(_on_transition_screen)


func _on_transition_screen():
	visible = true

	player.play("fade_out")

	await player.animation_finished

	GameService.complete_screen_transition()

	player.play("fade_in")

	await player.animation_finished

	visible = false

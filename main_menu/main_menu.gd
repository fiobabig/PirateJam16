extends Control

@onready var settings: Settings = %Settings
@onready var credits: Control = %Credits
@onready var tutorial: Tutorial = %Tutorial
@onready var quit: Button = %Quit


func _ready() -> void:
	GameService.started.connect(_on_started)

	settings.closed.connect(_on_settings_close)
	tutorial.begin.connect(_on_begin)

	settings.visible = false
	credits.visible = false
	tutorial.visible = false
	quit.visible = OS.get_name() != "Web"


func _on_start_pressed() -> void:
	tutorial.reset()
	tutorial.visible = true

	AnimationService.fade(tutorial)


func _on_started():
	visible = false


func _on_settings_pressed() -> void:
	settings.visible = true
	AudioService.button_select_menu.play()


func _on_settings_close() -> void:
	settings.visible = false
	AudioService.button_select_menu.play()


func _on_credits_pressed() -> void:
	credits.visible = true
	AudioService.button_select_menu.play()


func _on_close_credits_pressed() -> void:
	credits.visible = false
	AudioService.button_select_menu.play()


func _on_begin() -> void:
	await GameService.start_screen_transition()
	tutorial.visible = false
	GameService.start()


func _on_close_credits_mouse_entered() -> void:
	AudioService.button_mouse_over.play()


func _on_start_game_mouse_entered() -> void:
	AudioService.button_mouse_over.play()


func _on_settings_mouse_entered() -> void:
	AudioService.button_mouse_over.play()


func _on_credits_mouse_entered() -> void:
	AudioService.button_mouse_over.play()


func _on_begin_mouse_entered() -> void:
	AudioService.button_mouse_over.play()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_quit_mouse_entered() -> void:
	AudioService.button_mouse_over.play()

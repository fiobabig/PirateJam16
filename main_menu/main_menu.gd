extends Control

@onready var settings: Settings = %Settings
@onready var credits: Control = %Credits
@onready var tutorial: Control = %Tutorial
@onready var escape_menu: Control = %Tutorial


func _ready() -> void:
	GameService.started.connect(_on_started)

	settings.closed.connect(_on_settings_close)

	settings.visible = false
	credits.visible = false
	tutorial.visible = false


func _on_start_pressed() -> void:
	tutorial.visible = true


func _on_started():
	visible = false


func _on_settings_pressed() -> void:
	settings.visible = true


func _on_settings_close() -> void:
	settings.visible = false


func _on_credits_pressed() -> void:
	credits.visible = true


func _on_close_credits_pressed() -> void:
	credits.visible = false


func _on_begin_pressed() -> void:
	tutorial.visible = false
	GameService.start()

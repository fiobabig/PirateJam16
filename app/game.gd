extends Node2D

@onready var game_ui: CanvasItem = %GameUI
@onready var main_menu: CanvasItem = %MainMenu


func _ready() -> void:
	game_ui.visible = false
	main_menu.visible = true

	GameService.started.connect(_on_started)


func _on_started():
	BearerService.create()
	EventService.next()

	game_ui.visible = true
	main_menu.visible = false

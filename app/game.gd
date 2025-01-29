extends Node2D

@onready var game_ui: CanvasItem = %GameUI
@onready var main_menu: CanvasItem = %MainMenu
@onready var escape_menu: EscapeMenu = %EscapeMenu
@onready var screen_transition: CanvasItem = %ScreenTransition


func _ready() -> void:
	escape_menu.visible = false
	game_ui.visible = false
	main_menu.visible = true
	screen_transition.visible = false

	escape_menu.closed.connect(_on_escape_menu_closed)

	GameService.started.connect(_on_started)
	GameService.go_to_main_menu.connect(_on_go_to_main_menu)

	AudioService.game_music.play()


func _unhandled_input(event: InputEvent) -> void:
	if GameService.is_playing and Input.is_action_just_pressed("ui_cancel"):
		escape_menu.visible = !escape_menu.visible


func _on_go_to_main_menu():
	await GameService.start_screen_transition()

	SkillService.reset()
	BearerService.reset()
	EventService.reset()

	game_ui.visible = false
	main_menu.visible = true


func _on_started():
	BearerService.create()
	EventService.next()

	game_ui.visible = true
	main_menu.visible = false

	AudioService.game_start_sfx.play()


func _on_escape_menu_closed():
	escape_menu.visible = false

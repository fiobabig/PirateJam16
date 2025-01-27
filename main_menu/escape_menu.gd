extends Control
class_name EscapeMenu

signal closed


func _on_main_menu_pressed() -> void:
	closed.emit()
	GameService.main_menu()


func _on_close_pressed() -> void:
	closed.emit()

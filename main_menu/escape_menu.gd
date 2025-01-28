extends Control
class_name EscapeMenu

signal closed


func _on_main_menu_pressed() -> void:
	closed.emit()
	GameService.main_menu()
	AudioService.button_select_menu.play()


func _on_close_pressed() -> void:
	closed.emit()
	AudioService.button_select_menu.play()


func _on_main_menu_mouse_entered() -> void:
	AudioService.button_mouse_over.play()


func _on_close_mouse_entered() -> void:
	AudioService.button_mouse_over.play()

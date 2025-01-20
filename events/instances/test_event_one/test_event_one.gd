extends Node2D


func _on_button_pressed() -> void:
	EventService.go("test_event_two")

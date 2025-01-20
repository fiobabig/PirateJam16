extends Control


func _on_start_pressed() -> void:
	visible = false

	BearerService.create()
	EventService.go("test_event_one")

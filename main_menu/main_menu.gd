extends Control


func _on_start_pressed() -> void:
	visible = false

	BearerService.create()
	EventService.next()

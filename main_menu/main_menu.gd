extends Control


func _ready() -> void:
	GameService.started.connect(_on_started)


func _on_start_pressed() -> void:
	GameService.start()


func _on_started():
	visible = false

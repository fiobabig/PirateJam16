extends MarginContainer
class_name Tutorial

@onready var page_one: Control = %Page1
@onready var page_two: Control = %Page2

signal begin


func _ready() -> void:
	page_one.visible = true
	page_two.visible = false


func reset():
	page_one.visible = true
	page_two.visible = false


func _on_next_pressed() -> void:
	page_one.visible = false
	page_two.visible = true

	await AnimationService.fade(page_two)


func _on_begin_pressed() -> void:
	begin.emit()


func _on_mouse_entered() -> void:
	AudioService.button_mouse_over.play()

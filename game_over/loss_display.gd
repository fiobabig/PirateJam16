extends MarginContainer

@onready var label: Label = %Label

var _base_text: String = ""


func _ready() -> void:
	_base_text = label.text

	BearerService.changed.connect(_on_changed)


func _on_button_pressed() -> void:
	GameService.main_menu()


func _on_changed(bearer: BearerResource):
	label.text = _base_text.replace("[BEARER]", bearer.name)

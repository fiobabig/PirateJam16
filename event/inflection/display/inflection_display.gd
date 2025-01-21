extends MarginContainer

@onready var description: Label = %Description


func _ready() -> void:
	EventService.start_inflection.connect(_on_start_inflection)


func _on_continue_pressed() -> void:
	EventService.next()


func _on_start_inflection(inflection: InflectionResource):
	description.text = inflection.description

extends MarginContainer

@onready var description: Label = %Description
@onready var header: Label = %Header
@onready var result: RichTextLabel = %Result


func _ready() -> void:
	EventService.start_inflection.connect(_on_start_inflection)


func _on_continue_pressed() -> void:
	EventService.next()


func _on_start_inflection(inflection: InflectionResource, score_delta: float):
	var alignment = "lighter" if score_delta > 0 else "darker"
	var color = "f0f0f0" if alignment == "lighter" else "5B5B5B"
	alignment = "[outline_size=3][outline_color=#212821][color=#" + color + "]" + alignment + "[/color][/outline_color][/outline_size]"

	header.text = BearerService.current.name + " has reached an inflection point in their life..."
	description.text = inflection.description
	result.text = "Because of your influence, they have taken a " + alignment + " path..."

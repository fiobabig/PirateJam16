extends MarginContainer

@onready var decision_frame: Node = %DecisionFrame
@onready var description: Label = %Description
@onready var option1: Button = %Option1
@onready var option2: Button = %Option2

var _current_decision: Decision


func _ready() -> void:
	decision_frame.visible = false

	EventService.start_decision.connect(_on_start_decision)


func _on_start_decision(decision: Decision):
	decision_frame.visible = true
	_current_decision = decision
	description.text = decision.description
	option1.text = decision.options[0].text
	option2.text = decision.options[1].text


func _on_option_1_pressed() -> void:
	BearerService.update(_current_decision.options[0])
	EventService.next()


func _on_option_2_pressed() -> void:
	BearerService.update(_current_decision.options[1])
	EventService.next()

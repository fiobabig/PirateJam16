extends MarginContainer

@onready var description: Label = %Description
@onready var option1: Button = %Option1
@onready var option2: Button = %Option2
@onready var option1_stats: Label = %Option1Stats
@onready var option2_stats: Label = %Option2Stats

var _current_decision: Decision


func _ready() -> void:
	EventService.start_decision.connect(_on_start_decision)


func _on_start_decision(decision: Decision):
	_current_decision = decision
	description.text = decision.description
	option1.text = decision.options[0].text
	option2.text = decision.options[1].text

	option1_stats.text = (
		"B: "
		+ str(decision.options[0].bravery)
		+ " C: "
		+ str(decision.options[0].compassion)
		+ " J: "
		+ str(decision.options[0].justice)
		+ " T: "
		+ str(decision.options[0].temperance)
	)

	option2_stats.text = (
		"B: "
		+ str(decision.options[1].bravery)
		+ " C: "
		+ str(decision.options[1].compassion)
		+ " J: "
		+ str(decision.options[1].justice)
		+ " T: "
		+ str(decision.options[1].temperance)
	)


func _on_option_1_pressed() -> void:
	BearerService.update(_current_decision.options[0])
	EventService.next()


func _on_option_2_pressed() -> void:
	BearerService.update(_current_decision.options[1])
	EventService.next()

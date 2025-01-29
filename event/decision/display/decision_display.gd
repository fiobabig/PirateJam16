extends MarginContainer

@onready var description: Label = %Description
@onready var option1: Button = %Option1
@onready var option2: Button = %Option2
@onready var option1_stats: Label = %Option1Stats
@onready var option2_stats: Label = %Option2Stats

@onready var bravery_impact: StatImpact = %BraveryImpact
@onready var justice_impact: StatImpact = %JusticeImpact
@onready var compassion_impact: StatImpact = %CompassionImpact
@onready var temperance_impact: StatImpact = %TemperanceImpact

var _current_decision: Decision


func _ready() -> void:
	EventService.start_decision.connect(_on_start_decision)


func _on_start_decision(decision: Decision):
	_current_decision = decision

	description.text = decision.description.replace("[BEARER]", BearerService.current.name)
	option1.text = decision.options[0].text
	option2.text = decision.options[1].text

	AnimationService.dissolve(description)

	option1_stats.text = (
		"B: "
		+ str(decision.options[0].bravery)
		+ " J: "
		+ str(decision.options[0].justice)
		+ " C: "
		+ str(decision.options[0].compassion)
		+ " T: "
		+ str(decision.options[0].temperance)
	)

	option2_stats.text = (
		"B: "
		+ str(decision.options[1].bravery)
		+ " J: "
		+ str(decision.options[1].justice)
		+ " C: "
		+ str(decision.options[1].compassion)
		+ " T: "
		+ str(decision.options[1].temperance)
	)


func _on_option_1_pressed() -> void:
	BearerService.update(_current_decision.options[0])
	EventService.next()
	AudioService.button_select_decision.play()


func _on_option_2_pressed() -> void:
	BearerService.update(_current_decision.options[1])
	EventService.next()
	AudioService.button_select_decision.play()


func _on_option_1_mouse_entered() -> void:
	var option = _current_decision.options[0]

	bravery_impact.impact_scale = abs(option.bravery) / 25.0
	justice_impact.impact_scale = abs(option.justice) / 25.0
	compassion_impact.impact_scale = abs(option.compassion) / 25.0
	temperance_impact.impact_scale = abs(option.temperance) / 25.0
	AudioService.button_mouse_over.play()


func _on_option_2_mouse_entered() -> void:
	var option = _current_decision.options[1]

	bravery_impact.impact_scale = abs(option.bravery) / 25.0
	justice_impact.impact_scale = abs(option.justice) / 25.0
	compassion_impact.impact_scale = abs(option.compassion) / 25.0
	temperance_impact.impact_scale = abs(option.temperance) / 25.0
	AudioService.button_mouse_over.play()


func _on_option_mouse_exited() -> void:
	bravery_impact.impact_scale = 0.5
	justice_impact.impact_scale = 0.5
	compassion_impact.impact_scale = 0.5
	temperance_impact.impact_scale = 0.5

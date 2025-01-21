extends MarginContainer

@onready var bearer_display: CanvasItem = %BearerDisplay
@onready var decision_display: CanvasItem = %DecisionDisplay
@onready var inflection_display: CanvasItem = %InflectionDisplay
@onready var loss_display: CanvasItem = %LossDisplay
@onready var victory_evil: CanvasItem = %VictoryEvil
@onready var victory_good: CanvasItem = %VictoryGood


func _ready() -> void:
	_hide_all()

	EventService.start_decision.connect(_on_start_decision)
	EventService.start_inflection.connect(_on_start_inflection)
	EventService.victory_good.connect(_on_victory_good)
	EventService.victory_evil.connect(_on_victory_evil)
	EventService.unbonded.connect(_on_unbonded)


func _on_start_decision(decision: Decision):
	_hide_all()

	bearer_display.visible = true
	decision_display.visible = true


func _on_start_inflection(inflection: InflectionResource):
	_hide_all()

	bearer_display.visible = true
	inflection_display.visible = true


func _on_victory_good():
	_hide_all()

	victory_good.visible = true


func _on_victory_evil():
	_hide_all()

	victory_evil.visible = true


func _on_unbonded(bearer: BearerResource):
	_hide_all()

	loss_display.visible = true


func _hide_all():
	bearer_display.visible = false
	decision_display.visible = false
	inflection_display.visible = false
	victory_good.visible = false
	victory_evil.visible = false
	loss_display.visible = false

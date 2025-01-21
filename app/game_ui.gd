extends MarginContainer

@onready var bearer_display: CanvasItem = %BearerDisplay
@onready var decision_display: CanvasItem = %DecisionDisplay
@onready var inflection_display: CanvasItem = %InflectionDisplay
@onready var victory_good: CanvasItem = %VictoryGood
@onready var victory_evil: CanvasItem = %VictoryEvil


func _ready() -> void:
	bearer_display.visible = false
	decision_display.visible = false
	inflection_display.visible = false
	victory_good.visible = false
	victory_evil.visible = false

	EventService.start_decision.connect(_on_start_decision)
	EventService.start_inflection.connect(_on_start_inflection)
	EventService.victory_good.connect(_on_victory_good)
	EventService.victory_evil.connect(_on_victory_evil)


func _on_start_decision(decision: Decision):
	decision_display.visible = true
	inflection_display.visible = false
	victory_good.visible = false
	victory_evil.visible = false


func _on_start_inflection(inflection: InflectionResource):
	decision_display.visible = false
	inflection_display.visible = true
	victory_good.visible = false
	victory_evil.visible = false


func _on_victory_good():
	bearer_display.visible = false
	decision_display.visible = false
	inflection_display.visible = false
	victory_good.visible = true


func _on_victory_evil():
	bearer_display.visible = false
	decision_display.visible = false
	inflection_display.visible = false
	victory_evil.visible = true

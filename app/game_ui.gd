extends MarginContainer

@onready var bearer_display: CanvasItem = %BearerDisplay
@onready var decision_display: CanvasItem = %DecisionDisplay
@onready var inflection_display: CanvasItem = %InflectionDisplay


func _ready() -> void:
	decision_display.visible = false
	inflection_display.visible = false

	EventService.start_decision.connect(_on_start_decision)
	EventService.start_inflection.connect(_on_start_inflection)


func _on_start_decision(decision: Decision):
	decision_display.visible = true
	inflection_display.visible = false


func _on_start_inflection(inflection: InflectionResource):
	decision_display.visible = false
	inflection_display.visible = true

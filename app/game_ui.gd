extends MarginContainer

@onready var bearer_died: CanvasItem = %BearerDied
@onready var bearer_display: CanvasItem = %BearerDisplay
@onready var decision_display: CanvasItem = %DecisionDisplay
@onready var inflection_display: CanvasItem = %InflectionDisplay
@onready var loss_display: CanvasItem = %LossDisplay
@onready var victory_evil: CanvasItem = %VictoryEvil
@onready var victory_good: CanvasItem = %VictoryGood
@onready var right_panel: CanvasItem = %RightPanel


func _ready() -> void:
	_hide_all()

	EventService.start_decision.connect(_on_start_decision)
	EventService.start_inflection.connect(_on_start_inflection)
	EventService.victory_good.connect(_on_victory_good)
	EventService.victory_evil.connect(_on_victory_evil)
	EventService.unbonded.connect(_on_unbonded)
	EventService.bearer_died.connect(_on_bearer_died)

	GameService.started.connect(_on_started)


func _on_start_decision(decision: Decision):
	if not decision_display.visible:
		await GameService.start_screen_transition()

	_hide_all()

	#bearer_display.visible = true

	decision_display.visible = true
	right_panel.visible = true


func _on_start_inflection(inflection: InflectionResource, score_delta: float):
	await GameService.start_screen_transition()

	_hide_all()

	#bearer_display.visible = true
	inflection_display.visible = true
	right_panel.visible = true
	AudioService.game_start_sfx.play()


func _on_victory_good():
	await GameService.start_screen_transition()

	_hide_all()

	victory_good.visible = true
	AudioService.victory.play()


func _on_victory_evil():
	await GameService.start_screen_transition()

	_hide_all()

	victory_evil.visible = true
	AudioService.victory.play()


func _on_unbonded(bearer: BearerResource):
	await GameService.start_screen_transition()

	_hide_all()

	loss_display.visible = true
	AudioService.bond_broken.play()


func _on_bearer_died(dead_bearer: BearerResource):
	await GameService.start_screen_transition()

	_hide_all()

	bearer_died.visible = true
	AudioService.bearer_died.play()


func _on_started():
	_hide_all()

	decision_display.visible = true


func _hide_all():
	right_panel.visible = false
	bearer_died.visible = false
	bearer_display.visible = false
	decision_display.visible = false
	inflection_display.visible = false
	victory_good.visible = false
	victory_evil.visible = false
	loss_display.visible = false

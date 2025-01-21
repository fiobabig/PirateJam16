extends Node

signal start_decision(decision: Decision)
signal start_inflection(inflection: InflectionResource)
signal victory_good
signal victory_evil
signal unbonded(bearer: BearerResource)
signal bearer_died(previous: BearerResource, next: BearerResource)

@export var decisions: Array[Decision]
@export var inflections: Array[InflectionResource]

const SCORE_SCALE: float = 0.25

var _current_inflection: InflectionResource
var _score: float = 0.0  # -100 to 100
var _time_to_next_inflection: int = 3

enum Victory { None, Good, Evil }


func next():
	if _process_unbonded():
		return

	if _process_lifespan():
		return

	var victory = _process_victory()

	if victory == Victory.None:
		if _time_to_next_inflection > 0:
			_process_decision()
		else:
			_process_inflection()
	elif victory == Victory.Good:
		victory_good.emit()
	elif victory == Victory.Evil:
		victory_evil.emit()


func _process_decision():
	_time_to_next_inflection = _time_to_next_inflection - 1

	var decision = decisions[randi() % decisions.size()]

	start_decision.emit(decision)


func _process_inflection():
	_time_to_next_inflection = 3
	BearerService.decrease_lifespan()

	_current_inflection = inflections[randi() % inflections.size()]

	start_inflection.emit(_current_inflection)


func _process_victory() -> Victory:
	if _current_inflection == null:
		return Victory.None

	var score_delta = (
		(
			(BearerService.current.bravery * _current_inflection.bravery_weight)
			+ (BearerService.current.compassion * _current_inflection.compassion_weight)
			+ (BearerService.current.justice * _current_inflection.justice_weight)
			+ (BearerService.current.temperance * _current_inflection.temperance_weight)
		)
		* SCORE_SCALE
	)

	_score += score_delta
	_current_inflection = null

	if _score >= 100:
		return Victory.Good
	elif _score <= -100:
		return Victory.Evil
	else:
		return Victory.None


func _process_lifespan() -> bool:
	if BearerService.is_dead() == false:
		return false

	var previous = BearerService.current
	var next = BearerService.create()

	bearer_died.emit(previous, next)

	return true


func _process_unbonded() -> bool:
	if BearerService.is_unbonded() == false:
		return false

	unbonded.emit(BearerService.current)

	return true

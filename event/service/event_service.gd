extends Node

signal start_decision(decision: Decision)
signal start_inflection(inflection: InflectionResource, score_delta: float)
signal victory_good
signal victory_evil
signal unbonded(bearer: BearerResource)
signal bearer_died(previous: BearerResource, next: BearerResource)
signal score_changed(previous: float, next: float)

@export var decisions: Array[Decision]
@export var inflections: Array[InflectionResource]

const SCORE_SCALE: float = .25

var _current_inflection: InflectionResource
var _score: float = 0.0  # -100 to 100
var _time_to_next_inflection: int = 5

enum Victory { None, Good, Evil }


func next():
	if _process_unbonded():
		return

	var victory = _calculate_victory()

	if victory == Victory.None:
		if _time_to_next_inflection > 0:
			_process_decision()
		else:
			_process_inflection()
	elif victory == Victory.Good:
		victory_good.emit()
	elif victory == Victory.Evil:
		victory_evil.emit()

	if _process_lifespan():
		return


func _process_decision():
	_time_to_next_inflection = _time_to_next_inflection - 1

	var decision = decisions[randi() % decisions.size()]

	start_decision.emit(decision)


func _process_inflection():
	_time_to_next_inflection = 5  #Reset this somewhere instead of 2 different spots.
	BearerService.decrease_lifespan()

	_current_inflection = inflections[randi() % inflections.size()]

	var score_delta = _calculate_score_delta(BearerService.current, _current_inflection)

	start_inflection.emit(_current_inflection, score_delta)


func _calculate_victory() -> Victory:
	if _current_inflection == null:
		return Victory.None

	var previous_score = _score

	_score += _calculate_score_delta(BearerService.current, _current_inflection)

	_current_inflection = null

	score_changed.emit(previous_score, _score)

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


func _calculate_score_delta(bearer: BearerResource, inflection: InflectionResource):
	var bond_bonus = 0
	if bearer.bond > 0:
		bond_bonus = bearer.bond / 100.0

	var score_delta = (
		(
			(bearer.bravery * inflection.bravery_weight)
			+ (bearer.compassion * inflection.compassion_weight)
			+ (bearer.justice * inflection.justice_weight)
			+ (bearer.temperance * inflection.temperance_weight)
		)
		* SCORE_SCALE
	)
	print("scoreD: " + str(score_delta))
	return score_delta + score_delta * bond_bonus

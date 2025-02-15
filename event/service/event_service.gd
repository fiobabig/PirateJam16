extends Node

signal start_decision(decision: Decision)
signal start_inflection(inflection: InflectionResource, score_delta: float)
signal victory_good
signal victory_evil
signal unbonded(bearer: BearerResource)
signal bearer_died(dead_bearer: BearerResource)
signal score_changed(previous: float, next: float)

@export var decisions: Array[Decision]
@export var inflections: Array[InflectionResource]

@onready var _time_to_next_inflection = _inflection_time()

const SCORE_SCALE: float = .25

var _available_decisions: Array[Decision]
var _current_decision: Decision
var _current_inflection: InflectionResource
var _current_state: State
var _score: float = 0.0  # -100 to 100

enum Victory { None, Good, Evil }
enum State { Decision, Inflection }


func next():
	#_process_lifespan() short cicurit death
	#return

	match _current_state:
		State.Decision:
			if _process_unbonded():
				return

			if _time_to_next_inflection > 0:
				_process_decision()
			else:
				_process_inflection()
				_current_state = State.Inflection

		State.Inflection:
			var victory = _calculate_victory()

			if victory == Victory.Good:
				victory_good.emit()
			elif victory == Victory.Evil:
				victory_evil.emit()
			else:
				if _process_lifespan():
					return

				_current_inflection = null
				_current_state = State.Decision
				_process_decision()


func reset():
	_current_inflection = null
	_current_state = State.Decision
	_score = 0.0
	_time_to_next_inflection = _inflection_time()


func _process_decision():
	_time_to_next_inflection = _time_to_next_inflection - 1

	# if we have run through the whole list, refill it
	if _available_decisions.size() == 0:
		_available_decisions = decisions.duplicate()  # copy from the master list
		_available_decisions.shuffle()  # randomize the list

		# if the next item we'd grab would be the last one we did, shuffle again
	while _current_decision == _available_decisions[_available_decisions.size() - 1]:
		_available_decisions.shuffle()

	# use and remove the last item in the array
	var new_decision = _available_decisions.pop_back()

	_current_decision = new_decision

	start_decision.emit(new_decision)


func _process_inflection():
	_time_to_next_inflection = _inflection_time()
	BearerService.decrease_lifespan()

	_current_inflection = inflections[randi() % inflections.size()]

	var score_delta = _calculate_score_delta(BearerService.current, _current_inflection)

	start_inflection.emit(_current_inflection, score_delta)


func _calculate_victory() -> Victory:
	if _current_inflection == null:
		push_error("Inflection gone wrong, is null when calculating victory")

	var previous_score = _score

	_score += _calculate_score_delta(BearerService.current, _current_inflection)

	score_changed.emit(previous_score, _score)

	if _score >= 100:
		return Victory.Good
	elif _score <= -100:
		return Victory.Evil
	else:
		return Victory.None


func _inflection_time():
	if SkillService.has_skill(Enums.Skills.FasterInflections):
		return 3

	return 5


func _process_lifespan() -> bool:
	if BearerService.is_dead() == false:
		return false

	bearer_died.emit(BearerService.current)

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

	if SkillService.has_skill(Enums.Skills.OverReflect):
		score_delta *= 1.25

	return score_delta + (score_delta * bond_bonus)

extends Node

signal start_decision(decision: Decision)
signal start_inflection(inflection: InflectionResource)

@export var decisions: Array[Decision]
@export var inflections: Array[InflectionResource]

var _time_to_next_inflection: int = 3


func next():
	if _time_to_next_inflection > 0:
		_process_decision()
	else:
		_process_inflection()


func _process_decision():
	_time_to_next_inflection = _time_to_next_inflection - 1

	var decision = decisions[randi() % decisions.size()]

	start_decision.emit(decision)


func _process_inflection():
	_time_to_next_inflection = 3

	var inflection = inflections[randi() % inflections.size()]

	start_inflection.emit(inflection)

extends Node

#signal event_changed(event: EventResource)
#
#@export var events: Array[EventResource]
#
#
#func go(event_name: String):
#var event = _find_event(event_name)
#
#event_changed.emit(event)
#
#
#func _find_event(event_name: String):
#for e in events:
#if e.name == event_name:
#return e
#
#push_error("Couldn't find event {event_name}")

signal start_decision(decision: Decision)

@export var decisions: Array[Decision]


func next():
	var decision = decisions[randi() % decisions.size()]

	start_decision.emit(decision)

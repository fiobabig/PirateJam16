extends Node

signal changed(bearer: BearerResource)

var first_names: Array[String] = ["Kamden", "Eadwulf", "Leigh", "Camdyn", "Huxley"]
var last_names: Array[String] = ["Grovese", "Debenhame", "Brewere", "Goode", "Stoddarde"]

var _current: BearerResource


func create():
	var first_name = first_names[randi() % first_names.size()]
	var last_name = last_names[randi() % last_names.size()]

	_current = BearerResource.new()
	_current.name = first_name + " " + last_name
	_current.alignment = random_stat()
	_current.bond = 0
	_current.bravery = random_stat()
	_current.compassion = random_stat()

	changed.emit(_current)


func update(option: DecisionOption):  #dunno if I actually want to do it with a DecisionOption, but easy for now
	_current.bravery += option.bravery
	_current.compassion += option.compassion

	if sign(_current.alignment) == sign(option.alignment):
		_current.bond += abs(option.alignment)
	else:
		_current.bond -= abs(option.alignment)

	changed.emit(_current)


func random_stat():
	return randi() % 201 - 100

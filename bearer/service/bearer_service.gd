extends Node

signal changed(bearer: BearerResource)

var first_names: Array[String] = ["Kamden", "Eadwulf", "Leigh", "Camdyn", "Huxley"]
var last_names: Array[String] = ["Grovese", "Debenhame", "Brewere", "Goode", "Stoddarde"]

var _current: BearerResource
var current: BearerResource:
	get:
		return _current


func create() -> BearerResource:
	var first_name = first_names[randi() % first_names.size()]
	var last_name = last_names[randi() % last_names.size()]

	_current = BearerResource.new()
	_current.name = first_name + " " + last_name
	_current.alignment = _random_stat()
	_current.bond = 0
	_current.bravery = _random_stat()
	_current.compassion = _random_stat()
	_current.justice = _random_stat()
	_current.temperance = _random_stat()
	_current.lifespan = 1

	changed.emit(_current)

	return _current


func decrease_lifespan():
	_current.lifespan = _current.lifespan - 1

	changed.emit(_current)


func is_unbonded() -> bool:
	return _current.bond <= -100


func is_dead() -> bool:
	return _current.lifespan <= 0


func update(option: DecisionOption):
	_current.bravery = _cap(_current.bravery + option.bravery)
	_current.compassion = _cap(_current.compassion + option.compassion)
	_current.justice = _cap(_current.justice + option.justice)
	_current.temperance = _cap(_current.temperance + option.temperance)

	if sign(_current.alignment) == sign(option.alignment):
		_current.bond += abs(option.alignment)
	else:
		_current.bond -= abs(option.alignment)

	_current.bond = _cap(_current.bond)

	changed.emit(_current)


func _cap(value: int):
	if value > 100:
		return 100
	elif value < -100:
		return -100
	else:
		return value


func _random_stat():
	return randi() % 201 - 100

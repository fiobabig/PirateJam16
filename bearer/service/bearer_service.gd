extends Node

signal changed(bearer: BearerResource)

@export var portraits: Array[Texture2D] = []

var names: Array[String] = ["Kamden", "Eadwulf", "Leigh", "Camdyn", "Huxley", "Grovese", "Debenhame", "Brewere", "Goode", "Stoddarde"]

var _current: BearerResource
var current: BearerResource:
	get:
		return _current


func create() -> BearerResource:
	_current = BearerResource.new()
	_current.name = names[randi() % names.size()]
	_current.portrait = portraits[randi() % portraits.size()]

	# hit points
	_current.bond = 0

	# alignment
	_add_inclination(_current)

	# stats modified by decisions (inflection stats)
	_current.bravery = _random_stat()
	_current.compassion = _random_stat()
	_current.justice = _random_stat()
	_current.temperance = _random_stat()

	# longevity
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

	_current.bond += (
		(option.bravery * _current.bravery_inclination)
		+ (option.compassion * _current.compassion_inclination)
		+ (option.justice * _current.justice_inclination)
		+ (option.temperance * _current.temperance_inclination)
	)

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


func _add_inclination(bearer: BearerResource):
	bearer.bravery_inclination = 0.0
	bearer.compassion_inclination = 0.0
	bearer.justice_inclination = 0.0
	bearer.temperance_inclination = 0.0

	var primary_inclination_stat = randi_range(1, 4)
	var secondary_inclination_stat = randi_range(1, 4)

	var primary_inclination_value = -1.0 if randi_range(0, 1) == 0.0 else 1.0
	var secondary_inclination_value = 0.5 * (sign(primary_inclination_value) * -1)

	while secondary_inclination_stat == primary_inclination_stat:
		secondary_inclination_stat = randi_range(1, 4)

	match primary_inclination_stat:
		1:
			bearer.bravery_inclination = primary_inclination_value
			bearer.primary_inclination = Enums.Stats.Bravery
		2:
			bearer.compassion_inclination = primary_inclination_value
			bearer.primary_inclination = Enums.Stats.Compassion
		3:
			bearer.justice_inclination = primary_inclination_value
			bearer.primary_inclination = Enums.Stats.Justice
		4:
			bearer.temperance_inclination = primary_inclination_value
			bearer.primary_inclination = Enums.Stats.Temperance

	match secondary_inclination_stat:
		1:
			bearer.bravery_inclination = secondary_inclination_value
			bearer.secondary_inclination = Enums.Stats.Bravery
		2:
			bearer.compassion_inclination = secondary_inclination_value
			bearer.secondary_inclination = Enums.Stats.Compassion
		3:
			bearer.justice_inclination = secondary_inclination_value
			bearer.secondary_inclination = Enums.Stats.Justice
		4:
			bearer.temperance_inclination = secondary_inclination_value
			bearer.secondary_inclination = Enums.Stats.Temperance

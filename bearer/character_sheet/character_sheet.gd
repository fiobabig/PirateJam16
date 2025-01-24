extends Control

@export var primary_inclination_icon: Texture2D
@export var secondary_inclination_icon: Texture2D
@export var brightest_color: Color
@export var darkest_color: Color

@onready var portrait: TextureRect = %Portrait
@onready var name_label: Label = %Name

@onready var bravery: TextureRect = %Bravery
@onready var justice: TextureRect = %Justice
@onready var compassion: TextureRect = %Compassion
@onready var temperance: TextureRect = %Temperance

@onready var bravery_inclination: TextureRect = %BraveryInclination
@onready var justice_inclination: TextureRect = %JusticeInclination
@onready var compassion_inclination: TextureRect = %CompassionInclination
@onready var temperance_inclination: TextureRect = %TemperanceInclination


func _ready() -> void:
	BearerService.changed.connect(_on_changed)


func _on_changed(bearer: BearerResource):
	name_label.text = bearer.name
	portrait.texture = bearer.portrait

	bravery.modulate = _scale_color(bearer.bravery)
	compassion.modulate = _scale_color(bearer.compassion)
	justice.modulate = _scale_color(bearer.justice)
	temperance.modulate = _scale_color(bearer.temperance)

	_clear_inclination()

	match bearer.primary_inclination:
		Enums.Stats.Bravery:
			_set_inclination(bravery_inclination, primary_inclination_icon, bearer.bravery_inclination)
		Enums.Stats.Compassion:
			_set_inclination(compassion_inclination, primary_inclination_icon, bearer.compassion_inclination)
		Enums.Stats.Justice:
			_set_inclination(justice_inclination, primary_inclination_icon, bearer.justice_inclination)
		Enums.Stats.Temperance:
			_set_inclination(temperance_inclination, primary_inclination_icon, bearer.temperance_inclination)

	match bearer.secondary_inclination:
		Enums.Stats.Bravery:
			_set_inclination(bravery_inclination, secondary_inclination_icon, bearer.bravery_inclination)
		Enums.Stats.Compassion:
			_set_inclination(compassion_inclination, secondary_inclination_icon, bearer.compassion_inclination)
		Enums.Stats.Justice:
			_set_inclination(justice_inclination, secondary_inclination_icon, bearer.justice_inclination)
		Enums.Stats.Temperance:
			_set_inclination(temperance_inclination, secondary_inclination_icon, bearer.temperance_inclination)


func _scale_color(value: int):
	var scaled_value = value + 100.0  # move stats from -100 to 100 range -> 0 to 200 range
	var normalized_value = scaled_value / 200.0
	var result = lerp(darkest_color, brightest_color, normalized_value)

	return result


func _set_inclination(node: TextureRect, texture: Texture2D, value: float):
	node.texture = texture
	node.modulate = brightest_color if sign(value) > 0 else darkest_color
	node.flip_v = sign(value) < 0


func _clear_inclination():
	bravery_inclination.texture = null
	compassion_inclination.texture = null
	justice_inclination.texture = null
	temperance_inclination.texture = null

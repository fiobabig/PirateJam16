extends CenterContainer
class_name StatImpact

@onready var _icon: TextureRect = %Icon

var _max: Vector2
var _min: Vector2

var _scale: float = 0.5
var _tween: Tween

var impact_scale: float:
	get:
		return _scale
	set(value):
		_scale = clamp(value, 0.0, 1.0)
		_animate()


func _ready() -> void:
	_max = _icon.custom_minimum_size
	_min = _max * 0.5

	impact_scale = 0.5


func _animate():
	if _tween:
		_tween.kill()

	_tween = create_tween()
	_tween.tween_property(_icon, "custom_minimum_size", lerp(_min, _max, _scale), 0.15)

extends Sprite2D


func _ready() -> void:
	EventService.score_changed.connect(_on_score_changed)
	BearerService.bond_changed.connect(_on_bond_changed)


func _on_score_changed(previous: float, next: float):
	var score_delta = previous - next
	var score_speed = abs(score_delta) / 100
	var blend_scale = (next + 100) / 200

	var tween = create_tween()
	tween.tween_property(material, "shader_parameter/texture_mix_amount", blend_scale, score_speed)


func _on_bond_changed(previous: float, next: float):
	var delta = previous - next
	var speed = abs(delta) / 100

	var dissolve_scale = 1.0

	if next < 0:
		dissolve_scale = 1.0 - (abs(next) / 100.0) + 0.15  # adding the constant because the sword disappears completely at 0.15 dissolve_value

	var outline_scale = 0.0
	var outline_width = 0.0

	if next > 0:
		outline_scale = abs(next) / 100
		outline_width = 2.0 + (outline_scale * 3)

	var tween = create_tween()
	tween.tween_property(material, "shader_parameter/dissolve_value", dissolve_scale, speed)

	tween = create_tween()
	tween.tween_property(material, "shader_parameter/bond_outline_color:a", outline_scale, speed)

	tween = create_tween()
	tween.tween_property(material, "shader_parameter/bond_outline_width", outline_width, speed)

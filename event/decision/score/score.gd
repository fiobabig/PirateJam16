extends Control

@onready var gauge: Sprite2D = %Gauge


func _ready() -> void:
	EventService.score_changed.connect(_on_score_changed)


func _on_score_changed(previous: float, next: float):
	var score_delta = previous - next
	var score_speed = abs(score_delta) / 100

	var rot_scale = 1.0 - ((next + 100) / 200)
	var rot = -180 * rot_scale

	var tween = create_tween()
	tween.tween_property(gauge, "rotation_degrees", rot, score_speed)

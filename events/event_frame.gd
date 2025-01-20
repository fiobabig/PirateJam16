extends MarginContainer

@onready var content_contaner: Container = $ContentContainer
@onready var fade: ColorRect = $Fade

var _current_instance: Node


func _ready() -> void:
	fade.modulate.a = 0.0

	EventService.event_changed.connect(_on_event_changed)


func _on_event_changed(event: EventResource):
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1.0, 0.35)

	await tween.finished

	if _current_instance != null:
		_current_instance.queue_free()

	_current_instance = event.scene.instantiate()
	content_contaner.add_child(_current_instance)

	await get_tree().create_timer(0.35).timeout

	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0.0, 0.35)

	await tween.finished

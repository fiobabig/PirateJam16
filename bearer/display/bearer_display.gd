extends MarginContainer

@onready var name_label: Label = %Name
@onready var hp_label: Label = %HP


func _ready() -> void:
	BearerService.changed.connect(_on_bearer_changed)


func _on_bearer_changed(bearer: BearerResource):
	name_label.text = bearer.name
	hp_label.text = str(bearer.hp)

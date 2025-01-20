extends MarginContainer

@onready var name_label: Label = %Name
@onready var alignment_label: Label = %Alignment
@onready var bond_label: Label = %Bond
@onready var bravery_label: Label = %Bravery
@onready var compassion_label: Label = %Compassion


func _ready() -> void:
	visible = false
	BearerService.changed.connect(_on_bearer_changed)


func _on_bearer_changed(bearer: BearerResource):
	visible = true
	name_label.text = bearer.name
	alignment_label.text = "Alignment: " + str(bearer.alignment)
	bond_label.text = "Bond: " + str(bearer.bond)
	bravery_label.text = "Bravery: " + str(bearer.bravery)
	compassion_label.text = "Compassion: " + str(bearer.compassion)

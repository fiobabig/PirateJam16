extends MarginContainer

@onready var name_label: Label = %Name
@onready var alignment_label: Label = %Alignment
@onready var bond_label: Label = %Bond
@onready var bravery_label: Label = %Bravery
@onready var compassion_label: Label = %Compassion
@onready var justice_label: Label = %Justice
@onready var temperance_label: Label = %Temperance
@onready var lifespan_label: Label = %Lifespan
@onready var skills_label: Label = %Skills


func _ready() -> void:
	visible = false
	BearerService.changed.connect(_on_bearer_changed)
	SkillService.selected_changed.connect(_on_selected_changed)


func _on_bearer_changed(bearer: BearerResource):
	visible = true
	name_label.text = bearer.name
	alignment_label.text = "Alignment: " + str(bearer.alignment)
	bond_label.text = "Bond: " + str(bearer.bond)
	bravery_label.text = "Bravery: " + str(bearer.bravery)
	compassion_label.text = "Compassion: " + str(bearer.compassion)
	justice_label.text = "Justice: " + str(bearer.justice)
	temperance_label.text = "Temperance: " + str(bearer.temperance)
	lifespan_label.text = "Lifespan: " + str(bearer.lifespan)


func _on_selected_changed(skills: Array[Enums.Skills]):
	skills_label.text = "Skills: " + String(", ").join(skills.map(func(a): return SkillService.get_skill(a).name))

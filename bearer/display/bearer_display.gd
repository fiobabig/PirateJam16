extends MarginContainer

@onready var name_label: Label = %Name
@onready var bravery_inclination_label: Label = %BraveryInclination
@onready var compassion_inclination_label: Label = %CompassionInclination
@onready var justice_inclination_label: Label = %JusticeInclination
@onready var temperance_inclination_label: Label = %TemperanceInclination
@onready var bond_label: Label = %Bond
@onready var bravery_label: Label = %Bravery
@onready var compassion_label: Label = %Compassion
@onready var justice_label: Label = %Justice
@onready var temperance_label: Label = %Temperance
@onready var lifespan_label: Label = %Lifespan
@onready var skills_label: Label = %Skills
@onready var score_label: Label = %Score


func _ready() -> void:
	BearerService.changed.connect(_on_bearer_changed)
	SkillService.selected_changed.connect(_on_selected_changed)
	EventService.score_changed.connect(_on_score_changed)
	_on_score_changed(0)


func _on_score_changed(score: float):
	score_label.text = "Score: " + str(score)


func _on_bearer_changed(bearer: BearerResource):
	name_label.text = bearer.name
	bond_label.text = "Bond: " + str(bearer.bond)
	bravery_label.text = "Bravery: " + str(bearer.bravery)
	compassion_label.text = "Compassion: " + str(bearer.compassion)
	justice_label.text = "Justice: " + str(bearer.justice)
	temperance_label.text = "Temperance: " + str(bearer.temperance)
	lifespan_label.text = "Lifespan: " + str(bearer.lifespan)
	bravery_inclination_label.text = "Bravery Inclination: " + str(bearer.bravery_inclination)
	compassion_inclination_label.text = "Compassion Inclination: " + str(bearer.compassion_inclination)
	justice_inclination_label.text = "Justice Inclination: " + str(bearer.justice_inclination)
	temperance_inclination_label.text = "Temperance Inclination: " + str(bearer.temperance_inclination)


func _on_selected_changed(skills: Array[Enums.Skills]):
	skills_label.text = "Skills: " + String(", ").join(skills.map(func(a): return SkillService.get_skill(a).name))

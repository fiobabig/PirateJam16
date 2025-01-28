extends MarginContainer

@onready var continue_button: Button = %Continue
@onready var label: Label = %Label
@onready var portrait: Sprite2D = %Portrait
@onready var skill_selector: SkillSelector = %SkillSelector

var _selected_skill: Enums.Skills

# Main display of skills you current have.
# make the skill do something - ChuesDay
# let them continue if all skills have been selected already.


func _ready() -> void:
	EventService.bearer_died.connect(_on_bearer_died)
	skill_selector.selected.connect(_on_skill_selected)


func _on_bearer_died(dead_bearer: BearerResource):
	label.text = dead_bearer.name + " has gone to their ancestors"
	portrait.texture = dead_bearer.portrait
	AudioService.bearer_died.play()
	continue_button.visible = false
	skill_selector.update()


# Continue Button Press
func _on_continue_pressed() -> void:
	SkillService.add_skill(_selected_skill)
	BearerService.create()

	EventService.next()


func _on_skill_selected(skill: Enums.Skills):
	_selected_skill = skill
	continue_button.visible = true

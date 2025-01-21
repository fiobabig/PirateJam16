extends MarginContainer

@onready var continue_button: Button = %Continue
@onready var label: Label = %Label
@onready var skill_selector: SkillSelector = %SkillSelector

var _selected_skill: Enums.Skills


func _ready() -> void:
	EventService.bearer_died.connect(_on_bearer_died)
	skill_selector.selected.connect(_on_skill_selected)

	continue_button.visible = false


func _on_bearer_died(previous: BearerResource, next: BearerResource):
	label.text = previous.name + "died, now with more " + next.name + "!"


func _on_continue_pressed() -> void:
	SkillService.add_skill(_selected_skill)
	EventService.next()


func _on_skill_selected(skill: Enums.Skills):
	_selected_skill = skill
	continue_button.visible = true

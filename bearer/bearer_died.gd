extends MarginContainer

@onready var continue_button: Button = %Continue
@onready var label: Label = %Label
@onready var portrait: Sprite2D = %Portrait
@onready var skill_selector: SkillSelector = %SkillSelector

const _reasons: Array[String] = [
	"fell in a lake and drown", "fell in battle", "lost a duel", "died of old age", "succumbed to disease", "was poisoned by a rival", "was ravaged by a wild beast"
]
var _reason: String
var _selected_skill: Enums.Skills


func _ready() -> void:
	EventService.bearer_died.connect(_on_bearer_died)
	skill_selector.selected.connect(_on_skill_selected)


func _on_bearer_died(dead_bearer: BearerResource):
	var previous = _reason

	while previous == _reason:
		_reason = _reasons[randi() % _reasons.size()]

	label.text = dead_bearer.name + " " + _reason
	portrait.texture = dead_bearer.portrait
	skill_selector.update()

	continue_button.visible = SkillService.has_all_skills()


# Continue Button Press
func _on_continue_pressed() -> void:
	SkillService.add_skill(_selected_skill)
	BearerService.create()

	EventService.next()


func _on_skill_selected(skill: Enums.Skills):
	_selected_skill = skill
	continue_button.visible = true

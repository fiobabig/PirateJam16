extends MarginContainer
class_name SkillDisplay

signal selected(skill: Enums.Skills)

@onready var icon: TextureRect = %Icon
@onready var name_label: Label = %Name
@onready var description_label: Label = %Description

var _skill: Enums.Skills


func init(skill: SkillResource):
	_skill = skill.value

	name_label.text = skill.name
	description_label.text = skill.description
	icon.texture = skill.icon


func _gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		selected.emit(_skill)

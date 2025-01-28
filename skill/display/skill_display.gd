extends MarginContainer
class_name SkillDisplay

signal selected(skill: Enums.Skills)

@export var disabled_material: ShaderMaterial

@onready var icon: TextureRect = %Icon
@onready var name_label: Label = %Name
@onready var description_label: Label = %Description
@onready var selected_skill: Sprite2D = %SelectedSkill
@onready var wrapper: HBoxContainer = %Wrapper

var is_selected: bool:
	get:
		return selected_skill.visible
	set(value):
		selected_skill.visible = value

var skill: Enums.Skills


func _ready() -> void:
	is_selected = false


func init(skill: SkillResource, is_disabled: bool):
	self.skill = skill.value

	name_label.text = skill.name
	description_label.text = skill.description
	icon.texture = skill.icon

	# This works because we are reloading all skills each time the menu is loaded.
	if is_disabled:
		wrapper.mouse_filter = Control.MOUSE_FILTER_STOP
		icon.material = disabled_material


func _gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		selected.emit(skill)

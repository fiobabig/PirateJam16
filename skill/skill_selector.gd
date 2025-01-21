extends MarginContainer
class_name SkillSelector

signal selected(skill: SkillResource)

@export var skill_display_scene: PackedScene

@onready var skill_list: VBoxContainer = %SkillList


func _ready() -> void:
	for skill in SkillService.skills:
		var instance = skill_display_scene.instantiate()
		skill_list.add_child(instance)

		instance.init(skill)
		instance.selected.connect(_on_skill_selected)


func _on_skill_selected(skill: Enums.Skills):
	selected.emit(skill)

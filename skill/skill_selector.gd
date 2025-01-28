extends MarginContainer
class_name SkillSelector

signal selected(skill: SkillResource)

@export var skill_display_scene: PackedScene

@onready var skill_list: VBoxContainer = %SkillList


func update():
	for node in skill_list.get_children():
		node.queue_free()

	for skill in SkillService.skills:
		var instance = skill_display_scene.instantiate()
		skill_list.add_child(instance)

		instance.init(skill, SkillService.has_skill(skill.value))
		instance.selected.connect(_on_skill_selected)


func _on_skill_selected(skill: Enums.Skills):
	for node: SkillDisplay in skill_list.get_children():
		node.is_selected = node.skill == skill

	selected.emit(skill)

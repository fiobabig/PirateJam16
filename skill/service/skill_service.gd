extends Node

signal selected_changed(skills: Array[Enums.Skills])

@export var skills: Array[SkillResource] = []

var _selected_skills: Array[Enums.Skills] = []  # maybe just change it to store the resource instead and emit the resources instead of the enum


func has_skill(skill: Enums.Skills) -> bool:
	return skill in _selected_skills


func add_skill(skill: Enums.Skills):
	if has_skill(skill):
		return

	_selected_skills.append(skill)

	selected_changed.emit(_selected_skills)


func get_skill(skill: Enums.Skills):
	for s in skills:
		if s.value == skill:
			return s

	push_error("Unable to find skill: %skill" % skill)


func has_all_skills():
	return skills.size() == _selected_skills.size()


func reset():
	_selected_skills.clear()
	selected_changed.emit(_selected_skills)

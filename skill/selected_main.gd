extends HBoxContainer


func _ready() -> void:
	SkillService.selected_changed.connect(_on_selected_changed)
	for node in get_children():  # this is pulling straight from the root node and all it's children
		node.queue_free()


func _on_selected_changed(skills: Array[Enums.Skills]):
	for node in get_children():  # this is pulling straight from the root node and all it's children
		node.queue_free()

	for s in skills:
		var skill_resource = SkillService.get_skill(s)
		var texture_rect = TextureRect.new()

		texture_rect.texture = skill_resource.icon
		texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT

		add_child(texture_rect)

		# Intensify stat, Extreme Stats - no cap at 100, cap is now 150

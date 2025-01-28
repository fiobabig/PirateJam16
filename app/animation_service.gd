extends Node


func dissolve(node: Node, start: float = 0.0, end: float = 1.0, duration: float = 0.25):
	(node.material as ShaderMaterial).set_shader_parameter("dissolve_value", start)

	var tween = create_tween()
	tween.tween_property(node.material, "shader_parameter/dissolve_value", end, duration)

	return tween.finished


func fade(node: Node, start: float = 0.0, end: float = 1.0, duration: float = 0.25):
	var tween = create_tween()
	node.modulate.a = start

	tween.tween_property(node, "modulate:a", end, duration)

	return tween.finished


func dissolve_fade(node: Node, start: float = 0.0, end: float = 1.0, duration: float = 0.25):
	(node.material as ShaderMaterial).set_shader_parameter("shader_parameter/modulate:a", start)

	var tween = create_tween()
	tween.tween_property(node.material, "shader_parameter/modulate:a", end, duration)

	return tween.finished

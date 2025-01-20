extends Node

signal changed(bearer: BearerResource)

var current: BearerResource

var first_names: Array[String] = ["Kamden", "Eadwulf", "Leigh", "Camdyn", "Huxley"]
var last_names: Array[String] = ["Grovese", "Debenhame", "Brewere", "Goode", "Stoddarde"]


func create():
	var first_name = first_names[randi() % first_names.size()]
	var last_name = last_names[randi() % last_names.size()]

	current = BearerResource.new()
	current.name = first_name + " " + last_name
	current.hp = (randi() % 10) + 1

	changed.emit(current)

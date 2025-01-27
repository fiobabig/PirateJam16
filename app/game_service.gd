extends Node

signal go_to_main_menu
signal started

var is_playing = false


func main_menu():
	is_playing = false
	go_to_main_menu.emit()


func start():
	is_playing = true
	started.emit()

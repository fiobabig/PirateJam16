extends Node

signal go_to_main_menu
signal started
signal transition_screen
signal screen_transitioned

var is_playing = false


func main_menu():
	is_playing = false
	go_to_main_menu.emit()


func start():
	is_playing = true
	started.emit()


func start_screen_transition():
	transition_screen.emit()

	return screen_transitioned


func complete_screen_transition():
	screen_transitioned.emit()

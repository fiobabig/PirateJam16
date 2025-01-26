extends Node

signal go_to_main_menu
signal started


func main_menu():
	go_to_main_menu.emit()


func start():
	started.emit()

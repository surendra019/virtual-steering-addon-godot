@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("VirtualSteering", "TextureRect", preload("res://addons/Virtual Steering/steering.gd"), preload("res://addons/Virtual Steering/ic.png"))



func _exit_tree():
	remove_custom_type("VirtualSteering")

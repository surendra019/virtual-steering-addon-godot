# ===========================================================
# Virtual Steering Addon for Godot
# ===========================================================
# Description:
# This addon provides a virtual steering wheel system for 
# games and simulations built in Godot Engine. It includes 
# customizable options for sensitivity, rotation limits, and
# touch controls to simulate realistic steering behavior.
#
# Author: [surendra019]
# License: [MIT]
# Version: 1.0
# Date: [07-12-2024]
#
# Copyright (c) 2024 [surendra019]. All rights reserved.
#
# Disclaimer:
# This software is provided "as is" without any express or 
# implied warranties, including, but not limited to, the 
# implied warranties of merchantability and fitness for a 
# particular purpose.
# ===========================================================

@tool
extends TextureRect  # Attach this script to the steering handle's Sprite node

class_name VirtualSteering

@export var handle_rotation_limit = 180  # Maximum rotation in degrees (e.g., -90° to 90°)
@export var steering_rotation_limit = 60 # Maximum rotation in degrees for returning over the scale of -handle_rotation_limit to handle_rotation_limit.
@export_range(1, 12) var handle_sensitivity : float = 5.0
@export_range(1, 10) var handle_return_speed : float = 5.0
@export var horn_enabled: bool = true
@export var horn_stream: AudioStream = HORN
@export var horn_player: AudioStreamPlayer

# for example, if the handle_rotation_limit = 180, and steering_rotation_limit = 60;
		#the get_steering() will return a value between -60 to 60 for a range of -180 to 180.

var last_drag_position: Vector2
var released_handle: bool = false

const STEERING = preload("res://addons/Virtual Steering/steering.png")
const HORN = preload("res://addons/Virtual Steering/horn.mp3")

func _ready():
	if !ProjectSettings.get_setting("input_devices/pointing/emulate_touch_from_mouse"):
		printerr("Enable \"emulate touch from mouse\" in Project Settings")
		return
	_set_properties()
	set_process_input(true)


func _process(delta: float) -> void:
	pivot_offset = size / 2
	if released_handle:
		rotation = lerp(rotation, 0.0, .02 * handle_return_speed)
		if abs(rotation) <= .01:
			rotation = 0.0
			released_handle = false

# handles the touch and the drag.
func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		var local_current = event.position - pivot_offset
		var local_last = last_drag_position - pivot_offset
		var angle_diff = local_current.angle_to(local_last) * 2
		rotation_degrees = lerp(rotation_degrees, rotation_degrees - rad_to_deg(angle_diff) * handle_sensitivity / 5.0, .2)
		rotation_degrees = clamp(rotation_degrees, -handle_rotation_limit, handle_rotation_limit)
		last_drag_position = event.position
		released_handle = false
	elif event is InputEventScreenTouch:
		if event.pressed:
			released_handle = false
			last_drag_position = event.position
		else:
			released_handle = true


# sets the default proerties.
func _set_properties() -> void:
	if horn_enabled:
		if !horn_stream:
			printerr("horn_stream not assigned.")
		else:
			horn_player = AudioStreamPlayer.new()
			horn_player.stream = horn_stream
			add_child(horn_player)
			
			var horn_touch : Control = Control.new()
			add_child(horn_touch)
			horn_touch.size = size / 2.0
			horn_touch.position = pivot_offset - horn_touch.size / 2
			horn_touch.mouse_filter = Control.MOUSE_FILTER_PASS
			horn_touch.gui_input.connect(func(event):
				if event is InputEventScreenTouch:
					if event.pressed:
						play_horn()
					else:
						horn_player.stop()
				)
		
	texture = STEERING
	expand_mode = ExpandMode.EXPAND_IGNORE_SIZE
	stretch_mode = StretchMode.STRETCH_KEEP_ASPECT
	custom_minimum_size = Vector2(300, 300)
	
# returns the net steering.
func get_steering() -> float:
	if released_handle:
		return 0
	return -(convert_to_output(rotation))

# call this to play horn, only if the horn_enabled is true.
func play_horn() -> void:
	if horn_player:
		horn_player.play(.2)
		
# convert the handle's rotation to the output rotatin.
func convert_to_output(a: float) -> float:
	return a * deg_to_rad(steering_rotation_limit) / deg_to_rad(180)

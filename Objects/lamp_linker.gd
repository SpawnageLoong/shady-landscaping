extends Node2D

@onready var lamp_1: StaticBody2D = $linked_lamp_1
@onready var lamp_2: StaticBody2D = $linked_lamp_2

var linked_lamps = [lamp_1, lamp_2]


func rotate_linked_lamps():
	lamp_1.rotate_lamp()
	lamp_2.rotate_lamp()

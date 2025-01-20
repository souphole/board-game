class_name GlobalValues
extends Node
# these variables are meant for any node to edit and read

##put the die scenes here so you don't have to declare these scenes multiple times
const die_normal = preload("res://scenes_scripts/die/die.tscn")

const die_aurora = preload("res://scenes_scripts/die/die_aurora.tscn")

var add_default_roll_die = true #if true, when pressing the roll button a die will automatically be appended to the dice queue

var roll_enabled = true #if true, pressing the roll button will emit the pressed_roll signal and add a default roll die to the queue if add_default_roll_die is true

var dice_queue := [] #the main dice queue used by all the systems

var dice_mod := 0 #specifies if there should be a fixed amount that should be added to the roll. can be positive or negative

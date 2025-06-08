class_name LevelManager
extends Node

var level_name : String
##see if the player fininshed the level
var got_purple_jewel : bool = false
##see if the player got all the boxes in the level
var got_white_jewel : bool = false
##See if the player could beat the time record to get this jewel
var got_reliq : bool = false
##see if the player got in the secret passage
var got_blue_jewel : bool = false
##Check if the player finished the level ahead of the time to get the reliq
@export_group("Reliq Time")
var reliq_minutes
var reliq_seconds

@export_group("Best Time of conclusion")
var hours
var minutes
var seconds

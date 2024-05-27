extends Control

var Game = PackedScene

func _ready():
	Game = preload("res://Scenes/Game.tscn")

func _process(delta):
	if Input.is_action_just_pressed("teclaE"):
		get_tree().change_scene_to_packed(Game)

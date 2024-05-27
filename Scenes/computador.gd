extends StaticBody2D

var PC = PackedScene
@onready var player = $"../Player"

func _ready():
	player.connect("abriuPc", ligarPc)
	PC = preload("res://Scenes/PcAberto.tscn")

func ligarPc():
	get_tree().change_scene_to_packed(PC)


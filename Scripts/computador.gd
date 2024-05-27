extends StaticBody2D

@export var PC = PackedScene
@onready var player = $"../Player"

func _ready():
	print (player)
	player.connect("abriuPc", ligarPc)
	PC = preload("res://PcAberto.tscn")

func ligarPc():
	get_tree().change_scene_to_packed(PC)

extends StaticBody2D

var PC = PackedScene

func _ready():
	var player = get_node("/root/Path/To/Player")
	player.connect("abriuPc", ligarPc)
	PC = load("res://Scenes/computador.tscn")

func ligarPc():
	var PC_instance = PC.instance()
	add_child(PC_instance)

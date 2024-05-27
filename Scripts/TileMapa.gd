extends TileMap

@onready var map = $"."

func _ready() -> void:
	connect("MIDUP", MidUp)

func MidUp():
	map.set_layer_z_index(4,4)

func _process(delta):
	pass


#Colocar no script do player:
#if $".".is_colliding
#
#
#

#Colocar nesse script:
#func _process(delta):
#	map.set_layer_z_index(4,4)
#
#

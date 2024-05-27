extends StaticBody2D

@onready var RCR = $RayCastRight
@onready var RCL = $RayCastLeft
@onready var sprite = $AnimatedSprite2D

func _ready():
	RCR.add_exception($".")
	RCL.add_exception($".")

func _process(delta):
	if RCR.is_colliding():
		sprite.animation = "DireitaAberta"
	if RCL.is_colliding():
		sprite.animation = "EsquerdaAberta"
	if RCR.is_colliding() and RCL.is_colliding():
		sprite.animation = "TudoAberto"

extends CharacterBody2D

signal abriuPc
@onready var Comp = $"../Computador"
@onready var relative_offset: Vector2
@onready var caixa = $"../Caixa"
@onready var caixacol = $CollisionPolygon2D
@onready var Ray = $RayCast2D
@onready var sprite = $AnimatedSprite2D
@onready var player_rotation
@onready var offset
var Carrying = false
var direction = Vector2.ZERO
var speed
var running_speed = 300
var walking_speed = 175
var attacked = false
var lastver = 0  


#signal animation_finished

func _ready():
	pass
	#$Button.connect("pressed",	Callable(self, "_on_Button_pressed"))

func _process(delta):
	pass
	#if Input.is_action_pressed("mouse1"):
		#sprite.animation = "Hitting"
		#attacked = true
	#print(attacked)

func _physics_process(delta):
	
	#---------------------MOVIMENTO-------------------------------------------
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up","down")
	var acao = Input.is_action_just_pressed("teclaf")
	
	if Input.is_action_pressed("sprint") and !attacked:
		speed = running_speed
	else:
		speed = walking_speed
	
	direction = Vector2(direction_x, direction_y).normalized()
	
	#signal abriuPc
	#@onready var Comp = $"../Computador"
	if Input.is_action_just_pressed("teclaE") and Ray.get_collider() == Comp:
		emit_signal("abriuPc")
	print(Ray.get_collider())
	
	
	#---------------------ANIMAÇÃO_E_ATAQUE-----------------------------------
		
	if direction.x == 1 or direction.x == -1:
		sprite.animation = "Walk_Sides"
		lastver = 0
	elif direction.x == 0 and direction.y == 0:
		if lastver == 1:
			sprite.animation = "Idle_Down"
		elif lastver == -1:
			sprite.animation = "Idle_Up"
		else:
			sprite.animation = "Idle_Sides"
	elif direction.y == 1:
		sprite.animation = "Walk_Down"
		lastver = 1
	elif direction.y == -1:
		sprite.animation = "Walk_Up"
		lastver = -1
	
	
	#if Input.is_action_just_pressed("mouse1") and !attacked:
		#if direction.x == 0 and direction.y == 0:
			#if cima == true:
				#sprite.play("Attacking_Down")
				#attacked = true
				#cima = null
			#elif cima == false:
				#sprite.play("Attacking_Up")
				#attacked = true
				#cima = null
			#elif sprite.flip_h or !sprite.flip_h:
				#sprite.play("Attacking_Sides")
				#attacked = true
		#print("Iniciando animação de ataque")
	
	#---------------------PEGAR_ITEMS-----------------------------------------
	
	if direction.x != 0:
		Ray.rotation_degrees = 0 if direction.x > 0 else 180
	elif direction.y != 0:	
		Ray.rotation_degrees = 90 if direction.y > 0 else 270
		
	if Carrying == true and acao:
		caixa.visible = true
		player_rotation = self.rotation
		offset = relative_offset.rotated(player_rotation)
		caixa.position = self.position + offset
		Carrying = false
	if Ray.get_collider() == caixa and acao:
		caixa.visible = false
		caixa.position = Vector2(10000,10000)
		Carrying = true
		add_child(caixa)
	
	
	#---------------------VIRAR_SPRITE----------------------------------------
	if direction.x>0:
		sprite.flip_h = true
	elif direction.x<0:
		sprite.flip_h = false
	
	#---------------------CORRER----------------------------------------------
	if direction.x:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if direction.y:
		velocity.y = direction.y * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	
	
	move_and_slide()


#func _on_animation_finished():
	#print("Animação customizada finalizada")
	#attacked = false
	#sprite.play("Idle")
	#
#func _on_sprite_animation_finished():
	#print("Animação do sprite finalizada")
	#emit_signal("animation_finished") 

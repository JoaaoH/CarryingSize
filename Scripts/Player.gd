extends CharacterBody2D


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
var ray_direction
var mouse_position
var box_position
var max_distance = 50
var distance_from_player = 32
var timer
var total_steps = 100

#signal animation_finished

func _ready():
	 # Obtendo a referência para o nó Timer
	timer = $Timer
	# Conectando o sinal 'timeout' do Timer à função _on_Timer_timeout
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	# Configurando o tempo de espera do Timer para 1 segundo (1000 milissegundos)
	timer.wait_time = 1
	# Iniciando o Timer

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
	
	

	
	if direction.x != 0:
		Ray.rotation_degrees = 0 if direction.x > 0 else 180
	elif direction.y != 0:	
		Ray.rotation_degrees = 90 if direction.y > 0 else 270
	
	
	
	
	

	
	if Carrying:
		speed = 100
		
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
func _input(event):
	if event.is_action_pressed("mouse1"):
		var mouse_position = get_global_mouse_position()
		var distance_to_mouse = global_position.distance_to(mouse_position)
		
		if Carrying:
			# Soltar a caixa no local do mouse, limitado ao raio máximo
			if distance_to_mouse <= max_distance:
				caixa.position = mouse_position
				Carrying = false
				caixa.visible = true
			else:
				var ray_direction = (mouse_position - global_position).normalized()
				caixa.position = global_position + ray_direction * max_distance
				caixa.visible = true
				Carrying = false
		else:
			# Verificar se o RayCast está colidindo com a caixa e se está dentro do raio máximo
			if Ray.is_colliding() and Ray.get_collider() == caixa and distance_to_mouse <= max_distance:
				timer.start()

func _on_Timer_timeout():
	caixa.visible = false
	caixa.position = Vector2(10000, 10000)
	Carrying = true
	



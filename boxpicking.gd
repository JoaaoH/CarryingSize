#extends Control
#
#var time = 0.0
#const TIME_SCALE = 0.1
#@onready var progress_bar = $TextureProgressBar
#
#func _ready():
	#time = 0.0
#
#func _process(delta):
	#time += delta * TIME_SCALE
	#progress_bar.value += 1 * delta * TIME_SCALE
	#if progress_bar.value > progress_bar.max_value:
		#progress_bar.value = progress_bar.max_value
#
#func reset_progress():
	#progress_bar.value = 0
#
#func set_progress(value):
	#progress_bar.value = value
	
extends Control

const TIME_SCALE = 0.1

@onready var progress_bar = $TextureProgressBar

var time = 0.0

func _ready():
	# Inicializando o valor do tempo
	time = 0.0

func _process(delta):
	# Incrementando o tempo com base no delta e no TIME_SCALE
	time += delta * TIME_SCALE
	
	# Incrementando o valor da progress bar
	progress_bar.value += 1 * delta * TIME_SCALE
	
	# Garantindo que o valor não ultrapasse o valor máximo
	if progress_bar.value > progress_bar.max_value:
		progress_bar.value = progress_bar.max_value

# Função para redefinir o progresso, se necessário
func reset_progress():
	progress_bar.value = 0

# Função para definir o progresso para um valor específico, se necessário
func set_progress(value):
	progress_bar.value = value

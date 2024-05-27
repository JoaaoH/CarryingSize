extends Control

@export var duration: float = 1  # Tempo de duração em segundos
@onready var progress_bar = $TextureProgressBar
@onready var timer = $Timer

var elapsed_time = 0.0

func _ready():
	hide()
	reset_progress()
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))

func _process(delta):
	if elapsed_time < duration:
		elapsed_time += delta
		progress_bar.value = (elapsed_time / duration) * progress_bar.max_value

func start_progress():
	reset_progress()
	elapsed_time = 0.0
	timer.start(duration)

func _on_timer_timeout():
	# Finaliza o progresso quando o tempo do timer acabar
	progress_bar.value = progress_bar.max_value
	timer.stop()

func reset_progress():
	progress_bar.value = 0
	elapsed_time = 0.0

func set_progress(value):
	progress_bar.value = value

extends ProgressBar
@onready var progressbar = $ProgressBar
var progresso

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progressbar.get_fill_mode()


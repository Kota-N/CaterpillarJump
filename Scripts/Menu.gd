extends CanvasLayer

onready var tween = $Tween
onready var game = get_node("/root/Game")
onready var ground = get_node("/root/Game/Background/Ground")
onready var mid = get_node("/root/Game/Background/Mid")

signal start_pressed

func _ready():
	self.connect("start_pressed", game, "game_start")
	self.connect("start_pressed", ground, "start_scroll")
	self.connect("start_pressed", mid, "start_scroll")

func appear():
	tween.interpolate_property(self, "offset:y", -600, 0, 1.5, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tween.start()

func disappear():
	tween.interpolate_property(self, "offset:y", 0, -600, 0.5, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tween.start()


func _on_Button_pressed():
	emit_signal("start_pressed")

extends KinematicBody2D


var gravity = 70
var jump_speed = 1500
var velocity = Vector2()
var is_gameover = false
onready var animation = $AnimationPlayer
onready var jump_sound = $JumpSound
onready var gameover_sound = $GameoverSound

signal game_finished

func _ready():
	animation.current_animation = "run"
	self.connect("game_finished", get_node("/root/Game"), "back_to_menu")
	self.connect("game_finished", get_node("/root/Game/Background/Ground"), "stop_scroll")
	self.connect("game_finished", get_node("/root/Game/Background/Mid"), "stop_scroll")
	
func handle_gameover():
	if not is_gameover:
		emit_signal("game_finished")
		gameover_sound.play()
		is_gameover = true
		$CollisionShape2D.set_deferred("disabled", true)
		animation.current_animation = "gameover"

func get_input():
	if not is_gameover:
		velocity.y = -jump_speed
				
func _input(event):
	if is_on_floor() and event is InputEventScreenTouch and event.pressed:
		get_input()
		jump_sound.play()

func _physics_process(_delta):
	if self.global_position.y > 800:
		queue_free()
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)





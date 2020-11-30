extends Area2D

var velocity = Vector2()
var speed = 500

func _ready():
	var player = get_node("/root/Game/Player")
	self.connect("gameover", player, "handle_gameover")
	
	$AnimationPlayer.play("rotate")

signal gameover

func _process(delta):
	velocity.x = -speed
	position += velocity * delta
	
	if self.global_position.x < -100:
		queue_free()

func _on_Enemy_body_entered(body):
		emit_signal("gameover")

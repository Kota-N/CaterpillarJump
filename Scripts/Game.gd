extends Node2D

onready var enemy = preload("res://scenes/Enemy.tscn")
onready var player = preload("res://scenes/Player.tscn")
onready var enemy_timer = $EnemySpawnTimer
onready var menu = $Menu
onready var in_game_music = $InGameMusic
onready var menu_music = $MenuMusic
onready var start_sound = $StartSound
var rng = RandomNumberGenerator.new()
var spawn_time = 1


func _ready():
	menu.appear()
	rng.randomize()
	enemy_timer.stop()
	menu_music.play()
	
func game_start():
	start_sound.play()
	menu_music.stop()
	in_game_music.play()
	enemy_timer.start()
	menu.disappear()
	var player_instance = player.instance()
	add_child(player_instance)
	
func back_to_menu():
	in_game_music.stop()
	menu_music.play()
	enemy_timer.stop()
	menu.appear()
	
	

func _on_EnemySpawnTimer_timeout():
	spawn_time = rng.randf_range(0.7, 3.0)
	enemy_timer.wait_time = spawn_time
	add_child(enemy.instance())

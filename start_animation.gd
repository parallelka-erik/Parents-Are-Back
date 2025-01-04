extends Node2D



func _on_animated_sprite_2d_ready():
	$AnimatedSprite2D.play("Play2");


func _on_animated_sprite_2d_animation_finished():
	get_tree().change_scene_to_file("res://start_play.tscn")

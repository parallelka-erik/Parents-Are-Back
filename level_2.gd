extends Node2D

var momPreload = preload("res://mom.tscn")
@onready var player = $Player/Missie
var sees_Missie_box = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("actions") and sees_Missie_box:
		player.cartridges = 10;
		#if player.cartridges_in == 0:
			#player.reload_gun();	


func _on_spawner_timeout():
	if player.current_health != 0:
		mom_spawn();

func mom_spawn():
	var randomX;
	if int(randf_range (0, 100)) % 2 == 0:
		randomX = player.position.x - 1600
	else:
		randomX = player.position.x + 1600
	var mom = momPreload.instantiate();
	mom.position = Vector2(randomX, 570)
	$Mobs.add_child(mom);
	


func _on_reload_area_body_entered(body):
	if body.name=="Missie":
		sees_Missie_box = true;


func _on_reload_area_body_exited(body):
	if body.name=="Missie":
		sees_Missie_box = false;


func _on_reload_area_2_body_entered(body):
	if body.name=="Missie":
		sees_Missie_box = true;


func _on_reload_area_2_body_exited(body):
	if body.name=="Missie":
		sees_Missie_box = false;


func _on_reload_area_3_body_entered(body):
	if body.name=="Missie":
		sees_Missie_box = true;


func _on_reload_area_3_body_exited(body):
	if body.name=="Missie":
		sees_Missie_box = false;

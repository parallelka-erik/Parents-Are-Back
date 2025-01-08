extends Node2D

var momPreload = preload("res://mom.tscn")
@onready var player = $Player/Missie

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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

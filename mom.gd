extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -450.0
@onready var player = $"../../Player/Missie"
@onready var anim = $AnimatedSprite2D;
var alive = true
var attack_process = false;
var damage = 10 
var is_close_to_player = false;

func hit_and_hit():
	await $AnimatedSprite2D.animation_finished;
	player.take_damage(damage)
	hit_and_hit();
	
func _on_ready_to_hit_area_body_entered(body):
	velocity.x = 0;
	if body.name == "Missie":
		hit_and_hit();


		
		


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	var direction_chase = (player.position - self.position).normalized()
	var direction_val = player.position - self.position;
	if alive == true:
		if direction_val.x < 0:
			anim.flip_h = true;
		elif direction_val.x > 0:
			anim.flip_h = false;
		if abs(direction_val.x) > 50:
			velocity.x = direction_chase.x * SPEED;
			anim.play("Run");
		if abs(direction_val.x) <= 50 and abs(direction_val.y) < 20:
			anim.play("Attack");
		if abs(direction_val.x) <= 50 and abs(direction_val.y) > 20:
			velocity.x = 0;
			anim.play("Idle");
			

	
	
	move_and_slide();

extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -450.0
@onready var player = $"../../Player/Missie"
@onready var anim = $AnimatedSprite2D;
var alive = true
var ready_to_throw = false
var attack_process = false;
var damage = 25;
var is_close_to_player = false;

func throw_bottle(enemy):
	enemy.anim.play('Attack');
	await enemy.anim.animation_finished;
	

func hit_and_hit():
	await $AnimatedSprite2D.animation_finished;
	if alive == true:
		player.take_damage(damage)
	hit_and_hit();
	
func _on_ready_to_hit_area_body_entered(body):
	velocity.x = 0;
	if body.name == "Missie":
		hit_and_hit();

func mob_dies():
	collision_mask = 0
	collision_layer = 0;
	collision_mask |= (1 << 3)
	velocity.x = 0;
	anim.play("Hurt");
	await anim.animation_finished;
	queue_free();
		
		


func _physics_process(delta: float) -> void:
	if alive == false:
		mob_dies();
		
	# Add the gravity.
	if player.current_health == 0:
		anim.flip_h = false;
		anim.play("Idle");
		await anim.animation_finished;

	
	if not is_on_floor():
		velocity += get_gravity() * delta
	var direction_chase = (player.position - self.position).normalized()
	var direction_val = player.position - self.position;
	
	if player.position.y < 450:
		ready_to_throw = true;
	else:
		ready_to_throw = false;
	
	if alive and ready_to_throw:
		throw_bottle(self);
		if abs(direction_val.x) > 300:
			velocity.x = direction_chase.x * SPEED;
		if abs(direction_val.x) <= 300 and abs(direction_val.y) > 20:
			velocity.x = 0;
	
	if alive and !ready_to_throw:
		if abs(direction_val.x) > 50:
			anim.play("Run");
			velocity.x = direction_chase.x * SPEED;
		if abs(direction_val.x) <= 50 and abs(direction_val.y) < 20:
			anim.play("Attack");
		if abs(direction_val.x) <= 50 and abs(direction_val.y) > 20:
			anim.play("Idle");
			velocity.x = 0;
			
	
	if alive:
		if direction_val.x < 0:
			anim.flip_h = true;
		elif direction_val.x > 0:
			anim.flip_h = false;
		
			

	
	
	move_and_slide();

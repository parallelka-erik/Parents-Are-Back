extends CharacterBody2D

#health
var max_health = 1000
var current_health = max_health
@onready var health_bar = $Control/ProgressBarHealth
var mom_is_here = false;
var moms_in_area = [];


const SPEED = 300.0
const JUMP_VELOCITY = -500.0

@onready var anim = $AnimatedSprite2D



func _ready():
	connect("body_entered", Callable(self, "_on_shot_area_body_entered"));
	connect("body_exited", Callable(self, "_on_shot_area_body_exited"));
#health
	health_bar.max_value = max_health
	health_bar.value = current_health
	
func _on_shot_area_body_entered(body):
	if body.is_in_group("Enemy"):
		mom_is_here = true;
		moms_in_area.append(body);
	
func _on_shot_area_body_exited(body):
	if body.is_in_group("Enemy"):
		mom_is_here = false
		moms_in_area.erase(body);

func take_damage(damage):
	current_health -= damage
	if current_health < 0:
		current_health = 0
	health_bar.value = current_health

func _process(delta): 
	if mom_is_here and Input.is_action_pressed("shot"): 
		for obj in moms_in_area:
			obj.anim.play('Hurt');

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right");
	
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run");
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
	if direction == -1:
		anim.flip_h = true;
	elif direction == 1:
		anim.flip_h = false;
		
	if velocity.y > 400:
		anim.play("Fall");
	
	move_and_slide()

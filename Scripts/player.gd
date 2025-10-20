extends CharacterBody2D
var base_speed = 50
@export var speed = base_speed
@onready var animation_sprite = $AnimatedSprite2D

var new_direction = Vector2.ZERO
var is_attacking = false

func _physics_process(delta):
	var direction: Vector2
	
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
	
	if Input.is_action_pressed("ui_sprint"):
		speed = base_speed * 2
	if Input.is_action_just_released("ui_sprint"):
		speed = base_speed
	
	var movement = speed*direction*delta
	
	#if !Input.is_anything_pressed():
	if is_attacking == false:
		move_and_collide(movement)
		player_animation(direction)
	
func player_animation(direction: Vector2):
	var animation
	if direction != Vector2.ZERO:
		new_direction = direction
		animation = "walk_" + return_direction(new_direction)
		animation_sprite.play(animation)
	else:
		animation = "idle_" + return_direction(new_direction)
		animation_sprite.play(animation)

func return_direction(direction: Vector2):
	
	var normalized_direction = direction.normalized()
	var default_return = "side"
	
	if normalized_direction.y > 0:
		return "front"
	elif normalized_direction.y < 0:
		return "back"
	elif normalized_direction.x > 0:
		animation_sprite.flip_h = false
		return "side"
	elif normalized_direction.x < 0:
		animation_sprite.flip_h = true
		return "side"
	return default_return

func _input(event):
	if event.is_action_pressed("ui_attack"):
		is_attacking = true
		var animation = "attack_" + return_direction(new_direction)
		animation_sprite.play(animation)


func _on_animated_sprite_2d_animation_finished() -> void:
	is_attacking = false

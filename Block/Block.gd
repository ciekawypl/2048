class_name Block extends Area2D

@export var value : int = 2
@export var text : Label
@export var movement_component : MovementComponent
@export var collision_shape : CollisionShape2D

func _ready():
	update_text()


func update_text():
	text.text = str(value)


func has_point(point : Vector2):
	var shape = collision_shape.shape.get_rect().size
	
	if global_position.x - shape.x> point.x:
		return false
	if global_position.y - shape.y> point.y:
		return false
	if global_position.x + shape.x < point.x:
		return false
	if global_position.y + shape.y < point.y:
		return false
	
	return true


func move(direction : Vector2):
	var collider = movement_component.get_colliding_body(direction)
	if collider is Block:
		if collider.movement_component.can_move(direction):
			movement_component.move(direction, false)
			return
	
	movement_component.move(direction)


func manage_collision(_direction : Vector2, body : Variant):
	if body is Block:
		if body.value == value:
			body.value *= 2
			body.update_text()
			queue_free()

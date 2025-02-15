class_name BulletBase extends Area2D

var speed = 400					# 速度
var direction = Vector2(1,0)	# 方向
var hit_count = 0				# 穿透次数
var damage = 0

@onready var animation_player := $AnimationPlayer as AnimationPlayer

func destroy() -> void:
	queue_free()


func _on_body_entered(body: Node) -> void:
	if hit_count <= 0: return		# 避免同时触发的情况
	if body is EnemyBase:
		(body as EnemyBase).change_hp(-damage)
		
		hit_count -= 1			#减少穿透次数
		if hit_count <= 0:			
			direction = Vector2(0,0)
			speed = 0
			collision_layer = 0
			collision_mask = 0
			destroy()
			

func _physics_process(delta):
	position += speed * direction * delta


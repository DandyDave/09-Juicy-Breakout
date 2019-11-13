extends RigidBody2D

export var maxspeed = 300

signal lives
signal score
signal shake


func _ready():
 contact_monitor = true
 set_max_contacts_reported(4)
 var WorldNode = get_tree().get_current_scene()
 var CameraNode = get_node("/root/World/Camera2D")

 connect("score", WorldNode, "increase_score")
 connect("lives", WorldNode, "decrease_lives")
 connect("shake", CameraNode, "start")

func _physics_process(delta):
 var bodies = get_colliding_bodies()
 for body in bodies:
  if body.is_in_group("Tiles"):
   emit_signal("score",body.score)
   body.queue_free()
#   emit_signal("shake")
  if body.get_name() == "Paddle":
   pass
  
 if position.y > get_viewport_rect().end.y:
  emit_signal("lives")
  queue_free()

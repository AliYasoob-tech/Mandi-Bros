extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		GameManager.add_score(1)
		
		$PickupSound.play()
		$AnimatedSprite2D.hide()
		$CollisionShape2D.set_deferred("disabled",true)
		
		await $PickupSound.finished
		queue_free()

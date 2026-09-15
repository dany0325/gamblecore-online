extends Area2D

signal arm_pulled

func _on_mouse_entered() -> void:
	arm_pulled.emit()

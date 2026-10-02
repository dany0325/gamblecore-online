extends AnimatedSprite2D

var rng = RandomNumberGenerator.new()
var items = ["cherry", "coin", "clover", "lightning", "diamond", "six", "seven"]
var weights = PackedFloat32Array([25,20,18,15,12,7,3])
var rolled_item = "buh"


func _on_arm_pulled() -> void:
	rolled_item = items[rng.rand_weighted(weights)]

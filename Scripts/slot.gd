extends AnimatedSprite2D

var rng = RandomNumberGenerator.new()
var items = ["cherry", "coin", "clover", "lightning", "diamond", "six", "seven"]
var weights = PackedFloat32Array([1,1,2,3,4,5,5])
var rolled_item = "buh"


func _on_arm_pulled() -> void:
	rolled_item = items[rng.rand_weighted(weights)]

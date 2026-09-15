extends AnimatedSprite2D

var rng = RandomNumberGenerator.new()
#var items = ["cherry", "coin", "clover", "lightning", "diamond", "six", "seven"]
var items = ["1", "1", "2", "3", "4", "5", "4"]
var weights = PackedFloat32Array([1,1,2,3,4,5,4])



func _on_arm_pulled() -> void:
	print(items[rng.rand_weighted(weights)])

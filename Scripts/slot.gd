extends AnimatedSprite2D

var rng = RandomNumberGenerator.new()
var items = ["cherry", "coin", "clover", "lightning", "diamond", "six", "seven"]
var weights = PackedFloat32Array([25,20,18,15,12,7,3])

var rolled_item = "buh"



func _on_arm_pulled() -> void:
	rolled_item = items[rng.rand_weighted(weights)]
	if rolled_item == "cherry" :
		print("a1");
		#self.sprite_frames
		#sprite_frames.set_frame("cherry", 0, new_texture)
	elif rolled_item == "coin":
		print("a2")
	elif rolled_item == "clover":
		print("a3")
	elif rolled_item == "lightning":
		print("a4")
	elif rolled_item == "diamond":
		print("a5")
	elif rolled_item == "six":
		print("a6")
	elif rolled_item == "seven":
		print("a7")
	

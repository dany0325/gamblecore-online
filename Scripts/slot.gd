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
		play("cherry")
		scale = Vector2(0.05, 0.05)
	elif rolled_item == "coin":
		print("a2")
		play("coin")
		scale = Vector2(0.2, 0.2)
	elif rolled_item == "clover":
		print("a3")
		play("clover")
		scale = Vector2(0.045, 0.045)
	elif rolled_item == "lightning":
		print("a4")
		play("lightning")
		scale = Vector2(0.05, 0.05)
	elif rolled_item == "diamond":
		print("a5")
		play("diamond")
		scale = Vector2(0.07, 0.07)
	elif rolled_item == "six":
		print("a6")
		play("six")
		scale = Vector2(1, 1)
	elif rolled_item == "seven":
		print("a7")
		play("seven")
		scale = Vector2(1, 1)
	

extends Area2D

signal arm_pulled

@onready var spin_box: SpinBox = $"../SpinBox"
@onready var bet_change: Button = $"../BetChange"
@onready var player: Node = $"../../player"
@export var slots: Array[NodePath] = []
var results: Array = []
var item_multipliers = {"cherry":1, "coin":1.5, "clover": 2, "lightning":3, "diamond":5, "six":7, "seven":10}
var operation_cost
var streak_payout_ratios = {
	2: 1.0, 
	3: 3.0,
	4: 10.0,
	5: 35.0,
	6: 100.0,
	7: 300.0
}
#var items = ["cherry", "coin", "clover", "lightning", "diamond", "six", "seven"]
#var weights = PackedFloat32Array([1,1,2,3,4,5,5])

func _ready() -> void:
	bet_change.pressed.connect(_change_bet)
	operation_cost = int(spin_box.value)

func _change_bet():
	operation_cost = int(spin_box.value)

func _on_mouse_entered() -> void:
	if player.money < operation_cost:
		print("You're broke, get a loan or something")
	else:
		player.add_money(operation_cost*-1)
		arm_pulled.emit()
		results.clear()
		for slot_path in slots:
			var slot = get_node(slot_path)
			results.append(slot.rolled_item)
		_check_result(results)

func _check_result(items: Array) -> void:
	
	var first_item = items[0]
	var match_streak := 1
	for i in range(1, items.size()):
		if items[i] == first_item:
			match_streak += 1
		else:
			break

	if match_streak >= 2 and first_item in item_multipliers:
		var base_ratio: float = streak_payout_ratios.get(match_streak, 1.0)
		var item_tier: float = item_multipliers.get(first_item, 1.0)
			
			# Calculate total payout smoothly
		var total_payout := int(operation_cost * base_ratio * item_tier)
		
		if match_streak == items.size():
			print("JACKPOT! %d %ss! Payout: %d" % [match_streak, first_item, total_payout])
		else:
			print("%d %ss matched! Payout: %d" % [match_streak, first_item, total_payout])
		player.add_money(total_payout)
	else:
		print("No match")

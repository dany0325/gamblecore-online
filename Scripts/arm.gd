extends Area2D

signal arm_pulled

@onready var spin_box: SpinBox = $"../SpinBox"
@onready var bet_change: Button = $"../BetChange"
@onready var player: Node = $"../../player"
@export var slots: Array[NodePath] = []
var results: Array = []
var item_multipliers = {"cherry":1, "coin":1, "clover": 2, "lightning":3, "diamond":5, "six":7, "seven":10}
var operation_cost
var payouts: Dictionary:
	get:
		return {
			7: operation_cost * 250,
			6: operation_cost * 100,
			5: operation_cost * 40,
			4: operation_cost * 15,
			3: operation_cost * 5,
			2: operation_cost * 0.5
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
		print("lmao youre broke")
	else:
		player.add_money(operation_cost*-1)
		arm_pulled.emit()
		results.clear()
		for slot_path in slots:
			var slot = get_node(slot_path)
			results.append(slot.rolled_item)
		_check_result(results)

func _check_result(items: Array) -> void:
	var counts := {}
	for item in items:
		counts[item] = counts.get(item, 0) + 1

	var max_count := 0
	var winning_item = null
	for item in counts:
		if counts[item] > max_count:
			max_count = counts[item]
			winning_item = item

	var match_streak := 1

 	for i in range(1, items.size()):
		if items[i] == first_item:
			match_streak += 1
		else:
			break # Chain broke! Stop counting.

	if max_count == items.size():
		print("JACKPOT: all %d match! %s" % [items.size(), winning_item])
		player.add_money(int(payouts.get(max_count) * item_multipliers.get(winning_item)))
	elif max_count >= 2:
		print("%d matched: %s" % [max_count, winning_item])
		player.add_money(int(payouts.get(max_count) * item_multipliers.get(winning_item)))

	else:
		print("No match")
		
		

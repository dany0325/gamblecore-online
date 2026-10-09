extends Area2D

signal arm_pulled

@export var slots: Array[NodePath] = []
var results: Array = []
#var payouts = {3: 20, 2: 5}
#var item_multipliers = {"cherry":10, "coin":7, "clover": 5, "lightning":3, "diamond":2}
var item_multipliers = {"cherry":1, "coin":1.5, "clover": 2, "lightning":3, "diamond":5, "six":7, "seven":10}
var operation_cost
var streak_payout_ratios = {
	2: 2.0, #1.0, 
	3: 10.0, #3.0,
	4: 100.0, #10.0,
	5: 3500.0, #35.0,
	6: 10000.0, #100.0,
	7: 1000000.0 #300.0
}
#var items = ["cherry", "coin", "clover", "lightning", "diamond", "six", "seven"]

func _on_mouse_entered() -> void:
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

	if max_count == items.size():
		print("JACKPOT: all %d match! %s" % [items.size(), winning_item])
	elif max_count >= 2:
		print("%d matched: %s" % [max_count, winning_item])
		#if match_streak == items.size():
			#print("JACKPOT! %d %ss! Payout: %d" % [match_streak, first_item, total_payout])
		#else:
			#print("%d %ss matched! Payout: %d" % [match_streak, first_item, total_payout])
#
		#player.add_money(total_payout)
	else:
		print("No match")

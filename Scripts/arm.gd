extends Area2D

signal arm_pulled

@onready var spin_box: SpinBox = $"../SpinBox"
@onready var bet_change: Button = $"../BetChange"
@onready var player: Node = $"../../player"
@export var slots: Array[NodePath] = []
var results: Array = []
var item_multipliers = {"cherry":10, "coin":7, "clover": 5, "lightning":3, "diamond":2, "six":1, "seven":1}
var operation_cost = 5
var payouts = {3: operation_cost * 3, 2: operation_cost * 2}
#var items = ["cherry", "coin", "clover", "lightning", "diamond", "six", "seven"]

func _ready() -> void:
	bet_change.pressed.connect(_change_bet)

func _change_bet():
	operation_cost = spin_box.value * -1

func _on_mouse_entered() -> void:
	if player.money <= 0:
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

	if max_count == items.size():
		print("JACKPOT: all %d match! %s" % [items.size(), winning_item])
		player.add_money(payouts.get(max_count) * item_multipliers.get(winning_item))
	elif max_count >= 2:
		print("%d matched: %s" % [max_count, winning_item])
		player.add_money(payouts.get(max_count) * item_multipliers.get(winning_item))

	else:
		print("No match")
		
		

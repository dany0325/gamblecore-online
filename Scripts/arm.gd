extends Area2D

signal arm_pulled

@onready var spin_box: SpinBox = $SpinBox
@onready var player: Node = %player
@export var slots: Array[NodePath] = []
var results: Array = []
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

func _ready() -> void:
	input_pickable = true  # on by default for Area2D, but explicit is nice
	operation_cost = spin_box.value

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and event.pressed:
		spin_box.apply()                 # commits any typed text
		operation_cost = spin_box.value  # always current
		if player.money < operation_cost:
			print("Not enough money to pull")
			return
		player.add_money(-operation_cost)
		_pull_arm()

func _pull_arm() -> void:
	arm_pulled.emit()
	results.clear()

	for slot_path in slots:
		var slot = get_node(slot_path)
		results.append(slot.rolled_item)

	_check_result(results)

func _check_result(items: Array) -> void:
	if items.is_empty():
		return

	var counted_items = {"cherry":0, "coin":0, "clover": 0, "lightning":0, "diamond":0, "six":0, "seven":0}
	var streak := 1
	var streak_item := "cherry"
	
	
	for i in range(0, items.size()):
		counted_items[items[i]] += 1
		if counted_items[items[i]] > 1:
			if counted_items[items[i]] == streak and item_multipliers[items[i]] > item_multipliers[streak_item]:
				streak = counted_items[items[i]]
				streak_item = items[i]
			elif counted_items[items[i]] > streak:
				streak = counted_items[items[i]]
				streak_item = items[i]
	#var first_item = items[0]

	#for i in range(1, items.size()):
	#	if items[i] == first_item:
	#		streak += 1
	#	else:
	#		break

	
			
	if streak == items.size():
		print("JACKPOT: all %d match! %s" % [items.size(), streak_item])
		player.add_money(item_multipliers.get(streak_item) * streak_payout_ratios.get(streak) * operation_cost)
		print(item_multipliers.get(streak_item) * streak_payout_ratios.get(streak))
		
	elif streak >= 2:
		print("%d matched: %s" % [streak, streak_item])
		player.add_money(item_multipliers.get(streak_item) * streak_payout_ratios.get(streak) * operation_cost)
	else:
		print("No match")
		
	

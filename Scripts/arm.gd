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

func _on_spin_box_changed() -> void:
	operation_cost = spin_box.value

func _ready() -> void:
	input_pickable = true  # on by default for Area2D, but explicit is nice

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and event.pressed:
		_pull_arm()
		player.add_money(operation_cost * -1)

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

	var first_item = items[0]
	var streak := 1

	for i in range(1, items.size()):
		if items[i] == first_item:
			streak += 1
		else:
			break
			
	var total_payout = item_multipliers.get(first_item) * streak_payout_ratios.get(streak)
			
	if streak == items.size():
		print("JACKPOT: all %d match! %s" % [items.size(), first_item])
	elif streak >= 2:
		print("%d matched: %s" % [streak, first_item])
	else:
		print("No match")
		
	player.add_money(total_payout)

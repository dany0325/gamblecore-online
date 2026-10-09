extends Node

var money = 10;
var debt = 0
@onready var money_label: Label = $"../money_label"
@onready var debt_kabel: Label = $"../debt_kabel"
@onready var loan_gib: Button = $"../loan_gib"
@onready var aaaaaaaaaaaaaaaaa: Button = $"../aaaaaaaaaaaaaaaaa"

func _ready() -> void:
	loan_gib.pressed.connect(_loan_gib)
	aaaaaaaaaaaaaaaaa.pressed.connect(_loan_payoff)
	

func _process(_delta: float) -> void:
	money_label.text = "Money: " + str(money)
	debt_kabel.text = "Debt: " + str(debt)

func add_money(money_gained):
	money += money_gained

func _loan_gib():
	money += 100
	debt -= 120
	
func _loan_payoff():
	if money > 0:
		if (debt + money > 0):
			money += debt
			debt = 0
		else:
			var temp = money
			money -= temp
			debt += temp
	else:
		print("You don't have enough money to pay your loan, broke boy.") #print("kys jew. ingame")

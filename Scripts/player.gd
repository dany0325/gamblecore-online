extends Node

var money = 10;
@onready var money_label: Label = $"../money_label"

func add_money(money_gained):
	money += money_gained
	money_label.text = "Money: " + str(money)

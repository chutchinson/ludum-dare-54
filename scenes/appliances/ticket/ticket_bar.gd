extends Node

const TICKET = preload('res://scenes/appliances/ticket/ticket.tscn')

export(Array, Resource) var recipes = []

onready var _tickets = [$Ticket1, $Ticket2, $Ticket3]
var _count := 0

func _ready():
	randomize()
	for idx in range(0, len(_tickets)):
		var ticket = TICKET.instance() as Ticket
		recipes.shuffle()
		var recipe = recipes[0]
		ticket.recipe = recipe
		
		_tickets[_count].add_child(ticket)
		_count = min(_count + 1, len(_tickets))
	pass

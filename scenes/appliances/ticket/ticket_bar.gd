extends Node
class_name TicketBar

const TICKET = preload('res://scenes/appliances/ticket/ticket.tscn')

export(Array, Resource) var recipes = []

onready var _tickets = [$Ticket1, $Ticket2, $Ticket3]

var _count := 0
var _queue = []
var _recipes = []

func take() -> Recipe:
	var recipe = _recipes.pop_front()
	_update()
	return recipe

func _update():
	for slot in _tickets:
		for child in slot.get_children():
			child.queue_free()

	if len(_queue) == 0: return
	
	while len(_recipes) < len(_tickets):
		if len(_queue) == 0: break
		var recipe = _queue.pop_front()
		_recipes.push_back(recipe)
	
	for idx in range(0, len(_tickets)):
		if idx > len(_recipes) - 1: break
		var slot = _tickets[idx]
		var node = TICKET.instance()
		node.recipe = _recipes[idx]
		slot.add_child(node)
		
func _populate():
	for idx in range(0, len(recipes)):
		_queue.push_back(recipes[idx])

func _ready():
	_populate()
	_update()

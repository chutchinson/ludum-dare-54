extends Station
class_name OrderTray

const BOTTOM_BUN = preload('res://resources/ingredients/bun_bottom.tres')
const TOP_BUN = preload('res://resources/ingredients/bun_top.tres')

export(NodePath) var tickets = null

onready var _tickets = get_node(tickets) as TicketBar
onready var _pos = $Position3D

var order : Spatial = null

func inspect(chef):
	if _can_place_order(chef): 
		Game.inspect('Place Order')
	else: 
		if order != null: Game.inspect('(Existing order)')	
		else: Game.inspect('(Order required)')
	
func _can_place_order(chef: Chef) -> bool:
	return chef.is_holding_order() and order == null
	
func activate(chef: Chef):
	if _can_place_order(chef):
		order = chef.take_order()
		_pos.add_child(order)
		order.translation.y = 0.02

func submit():
	if order == null: return
	
	var recipe = _tickets.take()
	
	if recipe == null: return
	
	var counts = {}
	var score = 0
	
	for ingredient in order.ingredients:
		if not counts.has(ingredient): counts[ingredient] = 1
		else: counts[ingredient] += 1
		
	var perfect = true
	
	for idx in range(0, len(recipe.ingredients)):
		var ingredient = recipe.ingredients[idx]
		var count = recipe.counts[idx]
		
		if counts.has(ingredient) and counts[ingredient] == count: 
			score += 100
		elif counts.has(ingredient): 
			score += 10
			perfect = false
		else: 
			perfect = false
			
	for ingredient in order.ingredients:
		if ingredient == TOP_BUN: continue
		if ingredient == BOTTOM_BUN: continue
		if not recipe.ingredients.has(ingredient):
			perfect = false
		
	if perfect: score += 100
		
	Game.submit_order(score, perfect)
	
	for child in _pos.get_children():
		child.queue_free()
	
	order = null

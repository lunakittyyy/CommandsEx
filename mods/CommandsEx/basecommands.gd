extends Node

var main
var cExNode : Node
signal wagSignal
signal spawnSignal
signal helpSignal

func _enter_tree():
	cExNode = get_node("/root/CommandsEx")
	cExNode.register_command("wag", "wagSignal", self, "wagRecieve")
	cExNode.register_command("spawn", "spawnSignal", self, "spawnRecieve")
	cExNode.register_command("help", "helpSignal", self, "helpRecieve")

func wagRecieve(text, args):
	print("Waggy wag!")
	PlayerData.emit_signal("_wag_toggle")
	
func spawnRecieve(text, args):
	PlayerData.emit_signal("_return_to_spawn")
	
func helpRecieve(text, args):
	Network._update_chat("Commands:\n")
	var children = cExNode.get_children()
	var helpOut = "[color=red]"
	for i in children:
		if i.name.begins_with("ignore_"): continue
		helpOut = helpOut + i.get("commandText") + " "
	helpOut = helpOut + "[/color]"
	Network._update_chat(helpOut)

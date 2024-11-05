extends Node

var BaseCommands
const cmdRes = preload("res://mods/CommandsEx/Command.gd")
# concept borrowed from Lure
const _modules = {
	"ignore_BaseCommands":	preload("res://mods/CommandsEx/basecommands.gd")
}

func _enter_tree():
	_load_modules()
	
func _load_modules():
	for key in _modules.keys():
		var code = _modules[key]
		var node = code.new()
		node.name = key
		add_child(node)
		set(key, node)
		node.set("main", self)

func handle_command(text: String) -> void:
	var args = text.split(" ") # TODO: Probably not a great way to get args. Should we come back to this?
	for i in self.get_children():
		if i.name.begins_with("ignore_"): 
			continue
		if args[0] in "/" + i.get("commandText"):
			i._onCommand(text, args)

func register_command(command: String, recSignal: String, obj: Node, funcToCall: String) -> void:
	print("Registering command " + command)
	var cmdNode = cmdRes.new() as Node
	add_child(cmdNode)
	cmdNode.name = command
	cmdNode._cmdConnect(command, recSignal, obj, funcToCall)
	

extends Node

var BaseCommands
signal on_command(command, args)
# concept borrowed from Lure
const _modules = {
	"BaseCommands":	preload("res://mods/CommandsEx/basecommands.gd")
}

func _enter_tree():
	print("Loading builtin modules")
	_load_modules()
	
func _ready():
	print("Connecting basecommands")
	connect("on_command", BaseCommands, "_recieve")
	
func _load_modules():
	for key in _modules.keys():
		var code = _modules[key]
		var node = code.new()
		node.name = key
		add_child(node)
		set(key, node)
		node.set("main", self)

func handle_command(text: String) -> void:
	print("Handling command")
	var args = text.split(" ") # TODO: Probably not a great way to get args. Should we come back to this?
	emit_signal("on_command", text, args)

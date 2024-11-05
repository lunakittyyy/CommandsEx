extends Node

export var callFunc : String
export var commandText : String
var callingObj
var callingSignal

func _cmdConnect(command, recSignal, obj, funcToCall):
	commandText = command
	callingObj = obj
	callingSignal = recSignal
	callFunc = funcToCall
	callingObj.connect(recSignal, callingObj, funcToCall)

func _onCommand(text: String, args: PoolStringArray):
	print(callingSignal)
	callingObj.emit_signal(callingSignal, text, args)

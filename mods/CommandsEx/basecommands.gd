extends Node

var main

func _recieve(text, args):
	if (text == "/wag"):
		print("Waggy wag!")
		PlayerData.emit_signal("_wag_toggle")
	if (text == "/test"):
		PlayerData._send_notification("Aristotle versus MASHY SPIKE PLATE!!!!")
	

# CommandsEx

Allows developers to register commands in the WEBFISHING chat without patching, inside GDScript.

## API Code Example

```
func _ready():
    var node = get_node("/root/CommandsEx")
    node.connect("on_command", self, "_recieve")
    
func _recieve(text, args):
    if (text == "/mycommand"):
        PlayerData._send_notification("Now these points of data make a beautiful line")
        PlayerData._send_notification("We're out of beta we're releasing on time")
```

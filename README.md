# CommandsEx

Allows developers to register commands in the WEBFISHING chat without patching, inside GDScript.

## API Code Example

```
signal myCommandSignal

# you HAVE to register this in _enter_tree()!!!!!!!!
# If you don't register this here, it WILL NOT WORK and your node WILL NOT BE CREATED!!!
func _enter_tree():
    var node = get_node("/root/CommandsEx")
    # the parameters here are as follows, in order: command name, command signal, object signal belongs to, method to run on command
    node.register_command("mycommand", "myCommandSignal", self, "myCommandRecieve")
    
func myCommandRecieve(text, args):
    PlayerData._send_notification("Now these points of data make a beautiful line")
    PlayerData._send_notification("We're out of beta we're releasing on time")
```

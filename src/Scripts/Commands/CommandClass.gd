extends Node

class_name Commands


const commandDict : Dictionary = {"help" : "Shows the list containing all commands.", "clear" : "Clears the terminal's text."}


# PUBLIC METHODS

func executeCommand(command : String, terminal : Terminal):
	terminal.setWindowText(terminal.getWindowText() + command + "\n")
	if (command in commandDict.keys()):
		call("_" + command, terminal)
		return

	terminal.setWindowText(terminal.getWindowText() + terminal.TERMINAL_PATH)

# PRIVATE METHODS

func _getformattedHelpText():
	var text : String
	var spaces : String = "                 "
	var index = 0
	for key in commandDict:
		var slicingIndex : int = len(spaces) - len(key)
		text += key + spaces.substr(0, slicingIndex) + commandDict[key]
		if index != len(commandDict) - 1:
			text += "\n"
		index += 1

	return text


# COMMAND FUNCTIONS

func _help(terminal : Terminal):
	terminal.setPlaceholderText("clear")
	terminal.writeAnimatedText(_getformattedHelpText() + "\n" + terminal.TERMINAL_PATH)
	for i in range(len(commandDict)):
		terminal.adjustYPos(terminal.getEnterYOffset())


func _clear(terminal : Terminal):
	terminal.windowTextToOriginalSize()
	terminal.setWindowText(terminal.TERMINAL_PATH)
	terminal.setPlaceholderText("help")
	terminal.returnToOriginalPos()
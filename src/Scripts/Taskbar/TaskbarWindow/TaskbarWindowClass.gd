extends Node2D

class_name TaskbarWindow


var id : int
var img : CompressedTexture2D
var text : String

func _init(window : WindowDisplay):
	self.id = window.get_instance_id()
	self.img = window.getSpriteTexture()
	self.text = window.getTaskbarText()

	self._configureDisplay()


func _configureDisplay():
	WindowUtils.configureTaskbarWindowObj(self, self.img, self.text)
	var closeButton : TextureButton = WindowUtils.generateTaskbarWindowCloseButton()
	closeButton.connect("button_up", Taskbar.onCloseWindow.bind(self))
	self.add_child(closeButton)


# Method that is called when a window is exiting the scene. If the ids don't match, it is not the window exiting the scene.
func isActiveWindow(window : WindowDisplay):
	return window.get_instance_id() != self.id

func getTexture():
	return self.img
#this code creates the name input at the start
extends VBoxContainer

const CharacterInputButtonPreload = preload("res://charachterinputbutton.tscn")

var characters: Array[String] = [
	"A", "B", "C", "D", "E", "F", "G",
	"H", "I", "J", "K", "L", "M", "N",
	"R", "S", "T", "U", "V", "W", "X",
	"Y", "Z", "","",

	"a", "b", "c", "d", "e", "f", "g",
	"h","i","j", "k", "L", "m" ,"ח", "o"
	,"p","q", "r","s", "t", "u" ,"v", "w", "x",
	"y", "z", "", ""
]

var name_text: String = ""
var max_name_characters: int = 6

func _ready() -> void:
	for i in characters:
		var CharacterInputButton: Button = CharacterInputButtonPreload.instantiate()
		CharacterInputButton.text = i
		CharacterInputButton.self_modulate.a = 0.0
		CharacterInputButton.get_child(0).text = "[shake shake rate=22.0 level=8]" + i

		if i == "":
			CharacterInputButton.disabled = true
			CharacterInputButton.mouse_filter = Control.MOUSE_FILTER_IGNORE
			CharacterInputButton.focus_mode = Control.FOCUS_NONE

		CharacterInputButton.pressed.connect(CharacterButtonPressed.bind(i))
		$GridContainer.add_child(CharacterInputButton)

	_show_nameinputsystem()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		_on_backspace_pressed()

func CharacterButtonPressed(text: String) -> void:
	if name_text. length() == max_name_characters:
		name_text[max_name_characters-1] = text
	else:
		name_text += text
	$Name.text = name_text


func _show_nameinputsystem() -> void:
	#hide main menu content first!
	visible = true
	$GridContainer.get_child(0).grab_focus()

func _on_quit_pressed () -> void:
	name_text = ""
	$Name.text = ""
	visible = false
	#show main menu content now!

func _on_backspace_pressed () -> void:
	if name_text != "":
		name_text[name_text. length() -1] = ""
	$Name.text = name_text

func _on_done_pressed() -> void:
	if name_text != "":
		visible = false
		#make duplicate copy of Name Label visible,

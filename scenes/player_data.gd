extends Node

var save_path = "user://savedata.res"
var SaveData : SaveFile = null

func _ready():
	SaveData = load_character_data()
	if SaveData == null:
		SaveData = SaveFile.new()
		save_character_data(SaveData)
	else:
		if SaveData.SaveFileVersion < 3:
			SaveData.SaveFileVersion = 3
		if !SaveData.Controls.has("reset"):
			SaveData.Controls["reset"] = InputMap.action_get_events("reset")
			var NewEvent : InputEventKey = InputEventKey.new()
			NewEvent.pressed = true
			NewEvent.echo = false
			NewEvent.physical_keycode = KEY_F1
			NewEvent.keycode = DisplayServer.keyboard_get_keycode_from_physical(NewEvent.physical_keycode)
			NewEvent.key_label = NewEvent.keycode
			SaveData.Controls["reset"] = [NewEvent]
			print("set")
		if !has_meta("NHLBest"):
			set_meta("NHLBest", 0)
		if !has_meta("NHLPPBest"):
			set_meta("NHLPPBest", 0)
		save_character_data(SaveData)

func load_character_data():
	if ResourceLoader.exists(save_path):
		return load(save_path)
	return null

func save_character_data(data):
	var result = ResourceSaver.save(data, save_path)

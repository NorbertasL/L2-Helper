#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;HOTKEYS START
_ShoutTool_HotKey_ShowGUI:= "^w"
_ShoutTool_HotKey_Shout:= "^+w"
;HOTKEYS END

global shoutToolClass := new ShoutTool()


Hotkey,%_ShoutTool_HotKey_ShowGUI%,_ST_ShowGui,
Hotkey,%_ShoutTool_HotKey_Shout%,_ST_Shout,


_ST_ShowGui(){
	shoutToolClass.ShowGui()
}
_ST_Shout(){
	shoutToolClass.Shout()
}

class ShoutTool{
	__shoutString:= "Nothing to shout!"
	__enterToType:=false
	__autoSend:=false
	__New(){
		global addLineStr :=  "Add new line!...."
		;listArray := GetLinesFromFile("shouts.txt", "#")
		;listStr := addLineStr
		;for i, v in listArray
		;	listStr := listStr "|"v
		;listStr := Trim(listStr, "|")
	}

	ShowGui(){
		this.GenerateGui()
		Gui, ShoutGui:Show
	}
	HideGui(){
		Gui, ShoutGui:Hide
	}
	GenerateGui(){
		global
		MsgBox ShoutTool GenerateGui Called
		listStr := "Add new line!....|asdas|sdad|dasdas" ;Testing syting for GUI

		Gui, ShoutGui:New,, Shout GUI
		Gui, ShoutGui:Add, DropDownList, x22 y19 w430 h200 Choose1 vListItemSelect gOnListItemSelect,%listStr%
		Gui, ShoutGui:Add, Button, x22 y59 w120 h30 vSave gSave, Add
		Gui, ShoutGui:Add, Button, x172 y59 w130 h30 vDelete gDelete, Delete
		Gui, ShoutGui:Add, Button, x332 y59 w120 h30 gCancel, Cancel
		Gui, ShoutGui:Add, CheckBox,x22 y100 Checked vEnterToType, Enter to type?
		Gui, ShoutGui:Add, CheckBox,  Checked vAutoSend, AutoSend?

		GuiControl, Hide, Delete ; Hide this btn since we start with index on in list(add new item..)
	}

	Shout(){
		if(this.__enterToType){
			Send, {Enter}
		}
		temp:=this.__shoutString
		SendRaw %temp%

		if(this.__autoSend){
			Send, {Enter}
		}

	}
	setShoutString(str){
		this.__shoutString := str
	}
	getShoutString(){
			return this.__shoutString
	}
	setEnterToType(bool){
		this.__enterToType := bool
	}
	setAutoSend(bool){
		this.__autoSend := bool
	}
}
return
; GUI Logic
Save(){
	global
	GuiControlGet, Save
	if (Save = "Add"){
		MsgBox Adding new item!
	}else{
		GuiControlGet, ListItemSelect
		shoutToolClass.setShoutString(ListItemSelect)
		GuiControlGet, EnterToType
		shoutToolClass.setEnterToType(EnterToType)
		GuiControlGet, AutoSend
		shoutToolClass.setAutoSend(AutoSend)
		Gui, ShoutGui:Hide
	}
}
Delete(){
	ToolTip Delete was pressed!
}

Cancel(){
	ToolTip
	Gui, ShoutGui:Hide
}
OnListItemSelect(){
	global
	GuiControlGet, ListItemSelect
	if (ListItemSelect = addLineStr){
		GuiControl,, Save, Add
		GuiControl, Hide, Delete
	}
	else{
		GuiControl,, Save, OK
		GuiControl, Show, Delete
	}
}
;END GUI Logic


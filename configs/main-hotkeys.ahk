#Requires AutoHotkey v2.0
#SingleInstance Force

; Make CapsLock never toggle caps
SetCapsLockState "AlwaysOff"
CapsLock::Return

; "Caps layer": while CapsLock is physically held, remap arrows to Home/End
#HotIf GetKeyState("CapsLock", "P")
Left::Send "{Home}"
Right::Send "{End}"
^Left::Send "^{Home}"
^Right::Send "^{End}"
#HotIf


#q::Run "wt.exe"
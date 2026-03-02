#Requires AutoHotkey v2.0
#SingleInstance Force

; Make CapsLock never toggle caps
SetCapsLockState "AlwaysOff"
CapsLock::Return

; "Caps layer": while CapsLock is physically held, remap arrows to Home/End
#HotIf GetKeyState("CapsLock", "P")
Left::Send "{Home}"
Right::Send "{End}"

+Left::Send "+{Home}"
+Right::Send "+{End}"

^Left::Send "^{Home}"
^Right::Send "^{End}"

^+Left::Send "^+{Home}"
^+Right::Send "^+{End}"
#HotIf

; Open (or bring to top) Windows Terminal
#q::{
    ; Windows Terminal window class is usually this:
    termWin := WinExist("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")
    if !termWin
        termWin := WinExist("ahk_exe WindowsTerminal.exe") ; fallback

    if termWin {
        WinRestore("ahk_id " termWin)
        WinShow("ahk_id " termWin)
        WinActivate("ahk_id " termWin)
        DllCall("SetForegroundWindow", "ptr", termWin)
        return
    }

    Run "wt.exe"

    ; Wait for the window to exist, then force it to foreground
    if WinWait("ahk_class CASCADIA_HOSTING_WINDOW_CLASS", , 2) {
        termWin := WinExist("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")
        WinRestore("ahk_id " termWin)
        WinShow("ahk_id " termWin)
        WinActivate("ahk_id " termWin)
        DllCall("SetForegroundWindow", "ptr", termWin)
    }
}

; Open CopyQ
#+v::Run '"C:\Program Files\CopyQ\copyq.exe" toggle'

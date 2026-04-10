#Requires AutoHotkey v2.0
#SingleInstance Force

dllPath := A_ScriptDir "\VirtualDesktopAccessor.dll"
if !FileExist(dllPath) {
    MsgBox "VirtualDesktopAccessor.dll was not found in this script folder."
    ExitApp
}

hVDA := DllCall("LoadLibrary", "Str", dllPath, "Ptr")
if !hVDA {
    MsgBox "Could not load VirtualDesktopAccessor.dll."
    ExitApp
}

GetDesktopCountProc := DllCall("GetProcAddress", "Ptr", hVDA, "AStr", "GetDesktopCount", "Ptr")
GetCurrentDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVDA, "AStr", "GetCurrentDesktopNumber", "Ptr")
GoToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVDA, "AStr", "GoToDesktopNumber", "Ptr")
MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVDA, "AStr", "MoveWindowToDesktopNumber", "Ptr")

if !GetDesktopCountProc || !GetCurrentDesktopNumberProc || !GoToDesktopNumberProc || !MoveWindowToDesktopNumberProc {
    MsgBox "Could not find the required functions inside VirtualDesktopAccessor.dll."
    ExitApp
}

OnExit(FreeVDA)

; Win+1..Win+9 = go to desktops 1..9
; Win+0 = go to desktop 10
; Win+Shift+1..Win+Shift+9 = move active window to desktops 1..9
; Win+Shift+0 = move active window to desktop 10

Loop 9 {
    keyNum := A_Index
    Hotkey "#" . keyNum, GoToDesktopHotkey.Bind(keyNum - 1)
    Hotkey "#+" . keyNum, MoveWindowHotkey.Bind(keyNum - 1)
}

Hotkey "#0", GoToDesktopHotkey.Bind(9)
Hotkey "#+0", MoveWindowHotkey.Bind(9)

; On script startup:
; make sure 10 desktops exist, then select desktop 1
InitDesktops()

SetExactDesktopCount(requiredCount) {
    while GetDesktopCount() < requiredCount {
        Send("^#d")        ; Ctrl+Win+D
        Sleep(120)
    }

    while GetDesktopCount() > requiredCount {
        GoToDesktopNumber(GetDesktopCount() - 1)   ; go to the last desktop
        Sleep(80)
        Send("^#{F4}")     ; Ctrl+Win+F4 = close current desktop
        Sleep(120)
    }
}

GetDesktopCount() {
    global GetDesktopCountProc
    return DllCall(GetDesktopCountProc, "Int")
}

GetCurrentDesktopNumber() {
    global GetCurrentDesktopNumberProc
    return DllCall(GetCurrentDesktopNumberProc, "Int")
}

GoToDesktopNumber(desktopNumber) {
    global GoToDesktopNumberProc
    return DllCall(GoToDesktopNumberProc, "Int", desktopNumber, "Int")
}

MoveActiveWindowToDesktop(desktopNumber) {
    global MoveWindowToDesktopNumberProc
    try hwnd := WinGetID("A")
    catch TargetError
        return 0

    if !hwnd
        return 0
    return DllCall(MoveWindowToDesktopNumberProc, "Ptr", hwnd, "Int", desktopNumber, "Int")
}

EnsureDesktopCount(requiredCount) {
    originalDesktop := GetCurrentDesktopNumber()

    while GetDesktopCount() < requiredCount {
        Send("^#d")   ; Ctrl+Win+D = create another virtual desktop
        Sleep(120)
    }

    GoToDesktopNumber(originalDesktop)
    Sleep(50)
}

InitDesktops() {
    ; Create desktops until there are 10 total,
    ; then switch to the first desktop (internal number 0)
    SetExactDesktopCount(10)
    GoToDesktopNumber(0)
    Sleep(50)
}

GoToDesktopHotkey(desktopNumber, *) {
    EnsureDesktopCount(desktopNumber + 1)
    GoToDesktopNumber(desktopNumber)
    Sleep(100)
    Send("!{Tab}")
}

MoveWindowHotkey(desktopNumber, *) {
    EnsureDesktopCount(desktopNumber + 1)
    if MoveActiveWindowToDesktop(desktopNumber) {
        GoToDesktopNumber(desktopNumber)
        Sleep(100)
        Send("!{Tab}")
    }
}

FreeVDA(*) {
    global hVDA
    if hVDA
        DllCall("FreeLibrary", "Ptr", hVDA)
}
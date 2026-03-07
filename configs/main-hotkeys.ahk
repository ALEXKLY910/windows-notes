; Create a shortcut of this script and put it in the Startup folder (shell:startup)

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

; Open CopyQ
#+v::{
    Run '"C:\Program Files\CopyQ\copyq.exe" -e "toggle()"'
}


; Run Command Prompt and Powershell in the Terminal app
#q:: {
    Run 'wt.exe -p "Command Prompt"'
}
#+q:: {
    Run 'wt.exe -p "Windows PowerShell"'
}
#^q:: {
    Run '*RunAs wt.exe -p "Command Prompt"'
}
#^+q:: {
    Run '*RunAs wt.exe -p "Windows PowerShell"'
}

#c:: {
    Send "!{F4}"
}

#f:: {
    Send "{F11}"
}

; Win+S -> full screenshot to clipboard
#s::Send "{PrintScreen}"

; Win+Ctrl+S -> full screenshot to file
^#s::Send "#{PrintScreen}"

; Win+Ctrl+Shift+S -> regional screenshot to file via PicPick
^+#s::Send "+{PrintScreen}"


;Light Switch
#+t::Send "#^+d"
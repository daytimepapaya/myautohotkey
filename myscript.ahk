#Requires AutoHotkey v2.0

SendMode("Input")
SetWorkingDir(A_ScriptDir)

; make sure to save in UTF-8 with BOM

; search selected text with Everything
; Control + Alt + e
^!e:: {
    A_Clipboard := ""
    Send("^c")
    ClipWait(1)
    Run('"C:\Program Files\Everything\Everything.exe" -newwindow -s "' A_Clipboard '"')
}

; run fold program with selected file
; RightControl + f
#HotIf WinActive("ahk_class CabinetWClass")
>^f:: {
    A_Clipboard := ""
    Send("^c")
    ClipWait(1)
    MsgBox(A_Clipboard)
    ; Run(...)
}
#HotIf

; sort selected file.
; outputfile name is [original file name].sort
; RightControl + s
#HotIf WinActive("ahk_class CabinetWClass")
>^s:: {
    A_Clipboard := ""
    Send("^c")
    ClipWait(1)
    outputfile := A_Clipboard ".sort"
    Run('sort.exe "' A_Clipboard '" /O "' outputfile '"',, "Hide")
}
#HotIf

; ;dd to insert date and time
:*:;dd:: {
    TimeString := FormatTime(, "yyyy-MM-dd_HHmmss")
    Send(TimeString)
}

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; search selected text with Everything
; Control + Alt + e
^!e:: 
    clipboard := ""
    send ^c
    clipwait, 1
    Run, "C:\Program Files\Everything\Everything.exe" -newwindow -s "%clipboard%"
Return

; run fold program with selected file
; RightControl + f
#IfWinActive ahk_class CabinetWClass
>^f::
    clipboard := ""
    Send, ^c
    ClipWait, 1
    MsgBox, %clipboard%
    ; Run, 
Return
#IfWinActive

; sort selected file.
; outputfile name is [original file name].sort
; RightControl + s
#IfWinActive ahk_class CabinetWClass
>^s::
    clipboard := ""
    Send, ^c
    ClipWait, 1
    outputfile := clipboard ".sort"
    Run, sort.exe %clipboard% /O %outputfile%, ,Hide
Return
#IfWinActive

; ;dd to insert date and time
:*:;dd::
    FormatTime,TimeString,,yyyy/MM/dd HH:mm
    Send,%TimeString%
Return

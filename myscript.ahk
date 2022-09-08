#y:: 
clipboard := ""
send ^c
clipwait, 1
Run, "C:\Program Files\Everything\Everything.exe" -newwindow -s "%clipboard%"         ; change path if needed
return

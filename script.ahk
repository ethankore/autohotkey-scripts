; CTRL+ALT+L - Open my localhost directory
^!L:: 
Run d:\xampp\htdocs
Return

; CTRL+ALT+D - Open desktop directory
^!D::
Run c:\Users\%A_ComputerName%\Desktop
Return

; CTRL+ALT+X - Run Cmder
^!X::
Run C:\cmdr\Cmder.exe
Return

; --- For keyboards without media controls ---
; CTRL+F3 - Play/Pause music
^F3::
Send {Media_Play_Pause}
return

; CTRL+F8 - Previous track
^F8::
Send {Media_Prev}
return

; CTRL+F9 - Next track
^F9::
Send {Media_Next}
return

; CTRL+F10 - Volume down
^F10::setVolume("-5")

; CTRL+F11 - Volume up
^F11::setVolume("+5")

; CTRL+F1 - Mute
^F1::Send {VOLUME_MUTE}

; function for controlling the volume
SetVolume(whatvolume){
    soundset, %whatvolume%
    soundplay, *-1
}

; Alt+tilde - Move window from current monitor to the next (replace 'Right' with 'Left' to change the direction).
; To make it run properly, make sure your keyboard is using the English layout when enabling the script
!`::
Send {LWin down}{LShift down}{Right down}
Sleep 0
Send {LWin up}{LShift up}{Right up}
return

; Type :shrug: and you'll get ¯\_(ツ)_/¯
:B0:`:shrug::
	if (A_EndChar == ":") {
		SendInput, {BS 7}¯\_(ツ)_/¯
	}
return
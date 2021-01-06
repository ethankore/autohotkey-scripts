#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.

WindowTitles := ["Seinfeld", "13tv.co.il", "ערוץ 13", "ערוץ 12"]

!R::reload

; ALT+1 - Insert U+200F (rtl) character at the beginning of a line
!1::
	Send {Home}
	SendInput, ‏
	Return

; ALT+S - Detect a window which its title is included in WindowTitles, and toggle full screen
!S::
	WinGet, window,, A
	SetTitleMatchMode, 2

	For index, value in WindowTitles
		if WinExist(value) {
			WinActivate, %value%
			Sleep, 1
			Send {F11}
			Sleep, 1
			WinActivate, ahk_id %window%
		}
	Return

; ALT+S - Detect a window which its title is included in WindowTitles, and minimized state
!A::
	SetTitleMatchMode, 2

	For index, value in WindowTitles
		if WinExist(value) {
			WinGet, window,, %value%
			if WinExist("ahk_id" . window) {
				WinGet, WinState, MinMax
				if (WinState = -1)
					WinRestore
				else
					WinMinimize
			}
		}
	Return

; ALT+SHIFT+4 - Snip & Sketch
!+4::
	Run %A_WinDir%\explorer.exe ms-screenclip:
	Return

; CTRL+ALT+L - Open my localhost directory
^!L::
	Run d:\xampp\htdocs
	Return

; CTRL+ALT+D - Open desktop directory
^!D::
	Run c:\Users\%A_UserName%\Desktop
	Return

; CTRL+ALT+X - Run Alacritty/Windows Terminal
^!X::
	Run C:\Program Files\Alacritty\alacritty.exe
	; Run C:\Users\tkore2\AppData\Local\Microsoft\WindowsApps\wt.exe
	Return

; Ctrl-tilde - show/hide Alacritty window
^`::
	DetectHiddenWindows, on
	TerminalName := "ahk_exe Alacritty.exe"
	; TerminalName := "ahk_exe WindowsTerminal.exe"
	IfWinExist, %TerminalName%
	{
		IfWinActive, %TerminalName%
		{
			WinHide, %TerminalName%
			WinActivate ahk_class Shell_TrayWnd
		}
		else
		{
			WinShow, %TerminalName%
			WinActivate, %TerminalName%
		}
	}
	DetectHiddenWindows, off
	return

;Ctrl+F12 = Toggle AlwaysOnTop state of the active window
^F12::WinSet, AlwaysOnTop, Toggle, A

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

; Alt+tilde - Move window from current monitor to the next monitor on the right
; To make it run properly, make sure your keyboard is using the English layout when enabling the script
!`::
	Send {LWin down}{LShift down}{Right down}
	Send {LWin up}{LShift up}{Right up}
	return

; Alt+Shift+tilde - Move window from current monitor to the next monitor on the left
!+`::
	Send {LWin down}{LShift down}{Left down}
	Send {LWin up}{LShift up}{Left up}
	return

; Type /shrug and you'll get ¯\_(ツ)_/¯
::/shrug::
	SendInput, ¯\_(ツ)_/¯
	return


::/rtl::
	SendInput, ‏
	Return

::/ltr::
	SendInput, ‎
	Return

; Facepalm emoji, WhatsApp only
::/facepalm::
	SendInput, 🤦🏻‍♂
	return

; Ponder emoji, WhatsApp only
::/ponder::
	SendInput, 🤔
	return

; "lol" emoji. Facebook & WhatsApp
::/rofl::
	IfWinActive, WhatsApp
	{
		SendInput, 🤣
	} else {
		SendInput, 😂
	}
	return

; Take a wild guess
::/poop::
	SendInput, 💩
	return

; Sad face. WhatsApp only
::/sad::
	IfWinActive, WhatsApp
	{
		SendInput, ☹
	}
	return

; Metal. WhatsApp only
::/metal::
	SendInput, 🤘🏻😎🤘🏻
	return

; Up to no good :P
::/:P::
	SendInput, 😜
	return

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its speed and reliability.

WindowTitles := ["Seinfeld", "13tv.co.il", "ערוץ 13", "ערוץ 12"]

!R::reload

; ALT+1 - Insert U+200F (rtl) character at the beginning of a line
!1::
	Send {Home}
	SendInput, ‏
	Return

; ALT+S - Look for a window with a title matching an item from WindowTitles, and toggle full screen
!S::ToggleFullScreen(WindowTitles)
	
; ALT+A - Look for a window with a title matching an item from WindowTitles, and minimized state
!A::ToggleMinimizeAndRestore(WindowTitles)

; ALT+SHIFT+4 - Snip & Sketch
!+4::Run %A_WinDir%\explorer.exe ms-screenclip:

; CTRL+ALT+L - Open my localhost directory
^!L::Run d:\xampp\htdocs

; CTRL+ALT+D - Open desktop directory
^!D::Run c:\Users\%A_UserName%\Desktop

; CTRL+ALT+X - Run Alacritty/Windows Terminal
^!X::Run C:\Program Files\Alacritty\alacritty.exe

; Ctrl-tilde - show/hide Alacritty window
^`::ToggleWindowVisibility("ahk_exe Alacritty.exe")

;Ctrl+F12 = Toggle AlwaysOnTop state of the active window
^F12::WinSet, AlwaysOnTop, Toggle, A

; --- For keyboards without media controls ---
; CTRL+F3 - Play/Pause music
^F3::Send {Media_Play_Pause}

; CTRL+F8 - Previous track
^F8::Send {Media_Prev}

; CTRL+F9 - Next track
^F9::Send {Media_Next}

; CTRL+F10 - Volume down
^F10::setVolume("-5")

; CTRL+F11 - Volume up
^F11::setVolume("+5")

; CTRL+F1 - Mute
^F1::Send {VOLUME_MUTE}

; Alt+tilde - Move window from current monitor to the next monitor on the right
; To make it run properly, make sure your keyboard is using the English layout when enabling the script
!`::MoveWindowToRightMonitor()

; Alt+Shift+tilde - Move window from current monitor to the next monitor on the left
!+`::MoveWindowToLeftMonitor()

:*:/shrug::¯\_(ツ)_/¯

:*:/rtl::‏

:*:/ltr::‎

:*::facepalm::🤦🏻‍♂

:*::think::🤔

:*::rofl::🤣

:*::lol::😂

:*::poop::💩

:*::metal::🤘🏻😎🤘🏻

:*:::P::😜

ToggleWindowVisibility(windowClass) {
  DetectHiddenWindows, on

	IfWinExist, %windowClass%
	{
		IfWinActive, %windowClass%
		{
			WinHide, %windowClass%
			WinActivate ahk_class Shell_TrayWnd
		}
		else
		{
			WinShow, %windowClass%
			WinActivate, %windowClass%
		}
	}
	DetectHiddenWindows, off
}

; Look for a window with a title matching an item from given array, and toggle full screen
ToggleFullScreen(WindowsArr) {
  WinGet, activeWindow,, A
	SetTitleMatchMode, 2

	For currentIndex, windowName in WindowsArr {
		if WinExist(windowName) {
			WinActivate, %windowName%
			Sleep, 1
			Send {F11}
			Sleep, 1
			WinActivate, ahk_id %activeWindow%
		}

  }
}

; Look for a window with a title matching an item from given array, and toggle its minimized state
ToggleMinimizeAndRestore(windowTitlesArray) {
  SetTitleMatchMode, 2

	For i, winTitle in windowTitlesArray
		if WinExist(winTitle) {
			WinGet, window,, %winTitle%
			if WinExist("ahk_id" . window) {
				WinGet, WinState, MinMax
				if (WinState = -1)
					WinRestore
				else
					WinMinimize
			}
		}
	Return
}

MoveWindowToLeftMonitor() {
  Send {LWin down}{LShift down}{Left down}
	Send {LWin up}{LShift up}{Left up}
}

MoveWindowToRightMonitor() {
  Send {LWin down}{LShift down}{Right down}
	Send {LWin up}{LShift up}{Right up}
}

SetVolume(whatvolume){
	soundset, %whatvolume%
	soundplay, *-1
}
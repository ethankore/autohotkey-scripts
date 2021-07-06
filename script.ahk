#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its speed and reliability.

WindowTitlesToToggleMinimizedAndFullScreenStates := ["Seinfeld", "13tv.co.il", "ערוץ 13", "ערוץ 12", "חדשות 13", "המסך המפוצל", "VLC"]
ProcessNamesToToggleMuteOn := ["chrome.exe", "brave.exe"]
SoundUpAndDownVolumeStep = 10

; Increase or decrease volume using a specific step
; Originally written to make the Das Keyboard Professional volume knob less annoying, making it behave like it does on MacOS
$Volume_Up::IncreaseVolumeByStep(SoundUpAndDownVolumeStep)
$Volume_Down::DecreaseVolumeByStep(SoundUpAndDownVolumeStep)

; CTRL+F2 - Mute/unmute processes by filenames
^F2::ToggleMuteByProcessName(ProcessNamesToToggleMuteOn)

; ALT+R - Reload script
!R::reload

; ALT+1 - Insert U+200F (rtl) character at the beginning of a line
!1::InsertRtlCharacterAtBeginningOfLine()

; ALT+S - Look for a window with a title matching an item from WindowTitles, and toggle full screen
!S::ToggleFullScreen(WindowTitlesToToggleMinimizedAndFullScreenStates)

; ALT+A - Look for a window with a title matching an item from WindowTitles, and toggle minimized state
!a::ToggleMinimizeAndRestore(WindowTitlesToToggleMinimizedAndFullScreenStates)

; ALT+SHIFT+4 - Snip & Sketch
!+4::Run %A_WinDir%\explorer.exe ms-screenclip:

; CTRL+ALT+D - Open desktop directory
^!D::Run c:\Users\%A_UserName%\Desktop

; CTRL+ALT+X - Run Alacritty/Windows Terminal
^!X::Run C:\Program Files\Alacritty\alacritty.exe

; Ctrl-tilde - show/hide Alacritty window
^`::ToggleWindowVisibility("ahk_exe Alacritty.exe")

;Ctrl+F12 - Toggle AlwaysOnTop state of the active window
^F12::WinSet, AlwaysOnTop, Toggle, A

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

:*::id::200705895

:*:/rtl::‏

:*:/ltr::‎

:*::facepalm::🤦🏻‍♂

:*::thi::🤔

:*::shrug::🤷‍

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
ToggleFullScreen(WindowTitlesArray) {
  WinGet, activeWindow,, A
	SetTitleMatchMode, 2

	For i, WindowName in WindowTitlesArray {
		if WinExist(WindowName) {
			WinActivate, %WindowName%
			Sleep, 1
			Send {F11}
			Sleep, 1
			WinActivate, ahk_id %activeWindow%
		}

  }
}

; Look for a window with a title matching an item from given array, and toggle its minimized state
ToggleMinimizeAndRestore(WindowTitlesArray) {
  SetTitleMatchMode, 2

	For i, WinTitle in WindowTitlesArray
		if WinExist(WinTitle) {
			WinGet, window,, %WinTitle%
			if WinExist("ahk_id" . window) {
				WinGet, WinState, MinMax
				if (WinState = -1)
					WinRestore
				else
					WinMinimize
			}
		}
}

MoveWindowToLeftMonitor() {
  Send {LWin down}{LShift down}{Left down}
	Send {LWin up}{LShift up}{Left up}
}

MoveWindowToRightMonitor() {
  Send {LWin down}{LShift down}{Right down}
	Send {LWin up}{LShift up}{Right up}
}

SetVolume(newVolume){
	SoundSet, %newVolume%
	SoundPlay, *-1
}

InsertRtlCharacterAtBeginningOfLine() {
  Send {Home}
	SendInput, ‏
}

ToggleMuteByProcessName(processNames) {
  static areProcessesMuted = false

  for index, processName in processNames {
    If (areProcessesMuted = true) {
      Run %A_ScriptDir%\nircmd.exe setappvolume %processName% 1
    }
    Else {
      Run %A_ScriptDir%\nircmd.exe setappvolume %processName% 0
    }
  }

  areProcessesMuted := !areProcessesMuted
}

IncreaseVolumeByStep(step) {
  SoundGet, volume
  Send {Volume_Up}
  SoundSet, volume + step
}

DecreaseVolumeByStep(step) {
  SoundGet, volume
  Send {Volume_Down}
  SoundSet, volume - step
}

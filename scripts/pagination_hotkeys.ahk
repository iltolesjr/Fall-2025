#NoEnv
#SingleInstance Force
#Persistent
SetBatchLines, -1

; Hotkeys for pagination widgets (page input with prev/next arrows)
; Scope the hotkeys to browsers to avoid interfering elsewhere
#IfWinActive ahk_class Chrome_WidgetWin_1 || ahk_class MozillaWindowClass || ahk_class ApplicationFrameWindow

; Alt+Right / Alt+Left: trigger next/previous page
!Right::
    Send, {Right}
return

!Left::
    Send, {Left}
return

; Ctrl+Alt+G: prompt for a page number, then type it and press Enter.
; Click the page number box first (or Tab to it) before using this.
^!g::
    InputBox, page, Go to page, Enter a page number:, , 220, 140
    if ErrorLevel
        return
    if (page = "")
        return
    Send, %page%
    Send, {Enter}
return

; Alt+Shift+R: refresh the current page (sometimes needed when pagination stalls)
!+r::
    Send, ^r
return

#IfWinActive
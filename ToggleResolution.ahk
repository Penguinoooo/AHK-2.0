#Requires AutoHotkey v2.0
#SingleInstance Force

; HOTKEY: RightCtrl + RightAlt + R
>^>!r::
{
    nircmd := A_ScriptDir "\nircmd.exe"

    if !FileExist(nircmd) {
        MsgBox "ERROR:`nnircmd.exe not found.`nPlace it in the same folder as this script."
        return
    }

    ; Detect current resolution
    currentW := A_ScreenWidth
    currentH := A_ScreenHeight

    ; If currently 1440p → switch to 1080p
    if (currentW = 2560 && currentH = 1440)
    {
        Run(nircmd " setdisplay 1920 1080 32")
    }
    else
    {
        ; Otherwise switch to 1440p
        Run(nircmd " setdisplay 2560 1440 32")
    }
}

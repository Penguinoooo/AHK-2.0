#Requires AutoHotkey v2.0
#SingleInstance Force

; ==========================================================
; Ctrl + Shift + N → Create NewFile.txt in current folder
; ==========================================================
^+n::
{
    path := GetCurrentFolderPath()
    if path = ""
        return

    newFile := path "\NewFile.txt"

    if !FileExist(newFile)
        FileAppend("", newFile)

    Run(newFile)
}

; ==========================================================
; Ctrl + Shift + F → Create New Folder (auto-numbered)
; ==========================================================
^+f::
{
    path := GetCurrentFolderPath()
    if path = ""
        return

    baseName := "New Folder"
    newFolder := path "\" baseName
    idx := 2

    while FileExist(newFolder)
    {
        newFolder := path "\" baseName " (" idx ")"
        idx++
    }

    DirCreate(newFolder)
    Run(newFolder)
}

; ==========================================================
; Helper: Get Current Explorer Folder or Desktop
; ==========================================================
GetCurrentFolderPath()
{
    class := WinGetClass("A")

    if (class = "CabinetWClass")
    {
        shell := ComObject("Shell.Application")
        for window in shell.Windows
        {
            try
            {
                if (window.hwnd = WinGetID("A"))
                    return window.Document.Folder.Self.Path
            }
            catch
            {
            }
        }
    }
    else if (class = "WorkerW" || class = "Progman")
    {
        return A_Desktop
    }

    return ""
}
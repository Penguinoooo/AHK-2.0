#Requires AutoHotkey v2.0

^+F2::{
    hwnd := WinGetID("A")
    pid := WinGetPID(hwnd)

    static suspended := Map()

    if !suspended.Has(pid) || !suspended[pid]
    {
        SuspendProcess(pid)
        suspended[pid] := true
        TrayTip "Process Suspended", "PID: " pid, 1
    }
    else
    {
        ResumeProcess(pid)
        suspended[pid] := false
        TrayTip "Process Resumed", "PID: " pid, 1
    }
}

SuspendProcess(pid) {
    hProc := DllCall("OpenProcess", "UInt", 0x1F0FFF, "Int", 0, "UInt", pid, "Ptr")
    if !hProc
        return
    DllCall("ntdll\NtSuspendProcess", "Ptr", hProc)
    DllCall("CloseHandle", "Ptr", hProc)
}

ResumeProcess(pid) {
    hProc := DllCall("OpenProcess", "UInt", 0x1F0FFF, "Int", 0, "UInt", pid, "Ptr")
    if !hProc
        return
    DllCall("ntdll\NtResumeProcess", "Ptr", hProc)
    DllCall("CloseHandle", "Ptr", hProc)
}
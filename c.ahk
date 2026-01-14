#NoEnv
#SingleInstance Force
SendMode Input
#InstallKeybdHook

unlockCode := "7391"
firmwareOpen := false
armed := false
unlocked := false

; ================= TOGGLE KEY (TOP ROW 8) =================
8::
if (firmwareOpen) {
    ExitFirmware()
    return
}

armed := !armed
SoundBeep, armed ? 1500 : 600
return


; ================= LETTER TRIGGERS =================
~a::TriggerFirmware()
~b::TriggerFirmware()
~c::TriggerFirmware()
~d::TriggerFirmware()
~e::TriggerFirmware()
~f::TriggerFirmware()
~g::TriggerFirmware()
~h::TriggerFirmware()
~i::TriggerFirmware()
~j::TriggerFirmware()
~k::TriggerFirmware()
~l::TriggerFirmware()
~m::TriggerFirmware()
~n::TriggerFirmware()
~o::TriggerFirmware()
~p::TriggerFirmware()
~q::TriggerFirmware()
~r::TriggerFirmware()
~s::TriggerFirmware()
~t::TriggerFirmware()
~u::TriggerFirmware()
~v::TriggerFirmware()
~w::TriggerFirmware()
~x::TriggerFirmware()
~y::TriggerFirmware()
~z::TriggerFirmware()

return


; ================= FUNCTIONS =================

TriggerFirmware() {
    global armed, firmwareOpen, unlocked

    if (!armed)
        return

    if (firmwareOpen)
        return

    if (unlocked)   ; stop reopening after unlock
        return

    firmwareOpen := true
    ShowFirmware()
}

ShowFirmware() {
    global
    Gui, Destroy
    Gui, +AlwaysOnTop -Caption +ToolWindow
    Gui, Color, Black
    Gui, Font, cLime s11, Consolas

    Gui, Add, Text, x20 y10, Phoenix SecureCore Setup Utility
    Gui, Add, Text, x20 y40, ----------------------------------
    Gui, Add, Text, x20 y70, System Configuration Mode
    Gui, Add, Text, x20 y100, Authorization Required
    Gui, Add, Text, x20 y140, Enter Access Code:
    Gui, Add, Edit, x20 y170 w200 vInputCode Password
    Gui, Add, Button, x20 y210 w90 gVerifyCode, Continue

    Gui, Show, w360 h270, Firmware
}

VerifyCode:
Gui, Submit, NoHide

if (InputCode = unlockCode) {
    SoundBeep, 1500
    unlocked := true
    ShowSettings()
} else {
    SoundBeep, 400
}
return


ShowSettings() {
    Gui, Destroy
    Gui, +AlwaysOnTop -Caption +ToolWindow
    Gui, Color, Black
    Gui, Font, cLime s11, Consolas

    Gui, Add, Text, x20 y10, Phoenix SecureCore Setup Utility
    Gui, Add, Text, x20 y40, ----------------------------------
    Gui, Add, Text, x20 y80, Advanced System Configuration
    Gui, Add, Text, x20 y120, Boot Mode        : UEFI
    Gui, Add, Text, x20 y150, Secure Boot      : Enabled
    Gui, Add, Text, x20 y180, TPM Status       : Active
    Gui, Add, Text, x20 y210, Firmware Version : 5.12.9
    Gui, Add, Text, x20 y250, Press 8 to Exit

    Gui, Show, w420 h300, Firmware

    Hotkey, Esc, BlockEsc, On
}

ExitFirmware() {
    global firmwareOpen, armed, unlocked
    firmwareOpen := false
    armed := false
    unlocked := false
    Gui, Destroy
    Hotkey, Esc, Off
}

BlockEsc:
return

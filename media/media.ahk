;This script only works with 'Version 1.1.37.02'

F5::Send "{Media_Prev}"
F7::Send "{Media_Next}"
F6::Send "{Media_Play_Pause}"
F1::Send "{Volume_Mute}"
F2::Send "{Volume_Down}"
F3::Send "{Volume_Up}"

!Left::ControlSend, , +{Left}, ahk_class mpv
!Right::ControlSend, , +{Right}, ahk_class mpv
+Left::ControlSend, , {Left}, ahk_class mpv
+Right::ControlSend, , {Right}, ahk_class mpv


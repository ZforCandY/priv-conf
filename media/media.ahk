;This script only works with 'Version 1.1.37.02'

;Global media control
F5::Send "{Media_Prev}"
F7::Send "{Media_Next}"
F6::Send "{Media_Play_Pause}"
F1::Send "{Volume_Mute}"
F2::Send "{Volume_Down}"
F3::Send "{Volume_Up}"

;Seek supprt for mpv
!+,::ControlSend, , +{Left}, ahk_class mpv
!+.::ControlSend, , +{Right}, ahk_class mpv
+,::ControlSend, , {Left}, ahk_class mpv
+.::ControlSend, , {Right}, ahk_class mpv

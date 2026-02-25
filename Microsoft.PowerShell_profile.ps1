[System.Environment]::SetEnvironmentVariable('PATH',$Env:PATH+';;A:\IPFS\Apps\kubo_v0.38.0\kubo')
[System.Environment]::SetEnvironmentVariable('PATH',$Env:PATH+';;C:\Users\Administrator\Apps\kubo_v0.37.0\kubo')

#oh-my-posh init pwsh --config 'negligible' | Invoke-Expression

Set-Alias e emacs
Set-Alias ccl wx86cl64
Set-Alias f emacsclient
Set-Alias c clear
Set-Alias I timer
Set-Alias dr drracket
Set-Alias scp Scoop
Set-Alias scps Scoop-search
Set-Alias wz wezterm
Set-Alias p umpv

#function mpd {mpd C:\Users\Administrator\.mpd\mpd.conf -v}
function t{e -nw}
function dot{f $HOME\.emacs.d}
function m{f -n -c -a x}
function mt{B:\mintty\mintty-standalone\mintty-standalone-winpty-65001-pwsh5.cmd}
function me{autohotkey C:\Users\Administrator\media.ahk}
##function mc{mintty --exec cmd //k winpty -- powershell -NoExit -Command}
function d{e --daemon}

function rs{redshift -c C:\redshift.conf -v}
function rx{redshift -x}
function ps1{f ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1}
function org{f B:\C\org\plan.org}

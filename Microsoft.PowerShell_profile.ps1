[System.Environment]::SetEnvironmentVariable('PATH',$Env:PATH+';;A:\IPFS\Apps\kubo_v0.38.0\kubo')
[System.Environment]::SetEnvironmentVariable('PATH',$Env:PATH+';;C:\Users\Administrator\Apps\kubo_v0.37.0\kubo')

Set-Alias e emacs
Set-Alias ccl wx86cl64
Set-Alias f emacsclient
Set-Alias c clear

function t{e -nw}
function dot{f $HOME\.emacs.d}
function ec{f -n -c -a test.el}

function rs{redshift -c C:\redshift.conf -v}
function rx{redshift -x}
function ps1{f ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1}
function org{f B:\C\org\plan.org}


[System.Environment]::SetEnvironmentVariable('PATH',$Env:PATH+';;A:\IPFS\Apps\kubo_v0.38.0\kubo')

[System.Environment]::SetEnvironmentVariable('PATH',$Env:PATH+';;C:\Users\Administrator\Apps\kubo_v0.37.0\kubo')
Set-Alias ed edit
Set-Alias em emacs
Set-Alias ccl wx86cl64
Set-Alias ef emacsclient
# function ec
function  ec{emacsclient -n -c -a test.el}

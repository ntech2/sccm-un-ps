Dim objShell
Set objShell=CreateObject("WScript.Shell")
strExpression="Try {get-process -Name lync -ErrorAction Stop } Catch { Start-Process -FilePath lync.exe }"
strCMD="powershell -sta -noProfile -NonInteractive  -nologo -command " & Chr(34) &_
"&{" & strExpression &"}" & Chr(34) 
objShell.Run strCMD,0
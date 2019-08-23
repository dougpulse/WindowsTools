'This doesn't return any results

Set objArgs = WScript.Arguments


If Not objArgs.Named.Exists("elevate") Then
	If objArgs.Count = 1 Then
		a = objArgs(0)
	Else
		WScript.Quit
	End If
	CreateObject("Shell.Application").ShellExecute WScript.FullName, """" & WScript.ScriptFullName & """ /elevate """ & a & """", "", "runas", 1
	WScript.Quit
End If

Set wshShell = CreateObject("WScript.Shell")

s = objArgs.Count
For i = 0 to objArgs.Count - 1
	s = s & vbCrLf & objArgs(i)
Next

WScript.Echo s

If objArgs.Count = 1 Then
	fileOrFolderPath = InputBox("Enter file or folder path:")
	'WScript.Echo "No file provided."
Else
	fileOrFolderPath = objArgs(1)
End If

Set fso = CreateObject("Scripting.FileSystemObject")

If (fso.FileExists(fileOrFolderPath)) Then
	Set objExecObject = wshShell.Exec("cmd /c openfiles /query /fo table | find /I """ & fileOrFolderPath & """")
	strCmdOutput = ""
	Do While Not objExecObject.StdOut.AtEndOfStream
		strCmdOutput = strCmdOutput & objExecObject.StdOut.ReadLine()
	Loop 
	Wscript.Echo strCmdOutput
Else  
	WScript.Echo "File or directory does not exist."
End If

Set fso = Nothing
Set wshShell = Nothing

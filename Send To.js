//	When an object is dragged from Windows Explorer and dropped on something, 
//	the "something" receives a bit of text that is the full path of the object 
//	that was dragged.
//	
//	This script accepts a string as an argument.
//	
//	Intended use:  	Drop a file or folder on this script.
//					Shortcuts to the dropped files will be added to the 
//					SendTo list.
//	Warning:		Only filenames with a single dot (.) are supported.

var oArg = WScript.Arguments;
var sArg = "";

if (oArg.length == 0) {
	CreateSendTo(WScript.ScriptFullName);
}
else {
	for (var i = 0; i < oArg.length; i++) {
		sArg = oArg(i);
		CreateSendTo(sArg);
	}
}

function CreateSendTo(s) {
	var arrTemp = s.split("\\");
	var sFName = arrTemp[arrTemp.length - 1].split(".")[0];

	var WshShell = WScript.CreateObject("WScript.Shell");
	var sFile = WshShell.ExpandEnvironmentStrings("%appdata%") + "\\Microsoft\\Windows\\SendTo\\" + sFName + ".lnk";
	var oShellLink = WshShell.CreateShortcut(sFile);
	//oShellLink.TargetPath = WScript.ScriptFullName;
	oShellLink.TargetPath = s;
	oShellLink.WindowStyle = 1;
	//oShellLink.Hotkey = "CTRL+SHIFT+F";
	//oShellLink.IconLocation = "notepad.exe, 0";
	oShellLink.Description = sFName;
	oShellLink.WorkingDirectory = "C:\\";
	oShellLink.Save();
}

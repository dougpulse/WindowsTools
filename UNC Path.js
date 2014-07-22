//	When an object is dragged from Windows Explorer and dropped on something, 
//	the "something" receives a bit of text that is the full path of the object 
//	that was dragged.
//	
//	This script accepts a string as an argument.
//	
//	Intended use:  	Drop a file or folder on this script.
//					A string containing the full UNC path of each object 
//					dropped will be placed on the clipboard, delimited 
//					by \r\n.
//	
//	Revision History:
//	Date		Developer	Change
//	2/3/2012	d. pulse	understands local drives
//	9/27/2013	d. pulse	tested more options and landed on using clip.exe to write to the clipboard
//	

var oNet = WScript.CreateObject("WScript.Network");
var oDrives = oNet.EnumNetworkDrives();

var oArg = WScript.Arguments;
var sDrive = new Array();
var sOut = "";

var sUNC = "";
if (oArg.length > 0) {
	for (var i = 0; i < oArg.length; i++) {
		sDrive.push(oArg(i).substr(0, 2));
	}
	
	var sObj = "{MappedDrives = {\r\n"
	for (i = 0; i < oDrives.Count(); i += 2){
		sObj += "\t\"" + oDrives.Item(i) + "\": \"" + oDrives.Item(i + 1).replace(/\\/gi, "\\\\") + "\"";
		if (i < oDrives.Count() - 2) sObj += ",";
		sObj += "\r\n";
	}
	sObj += "\t}\r\n}";
	
	eval(sObj);
	
	for (var i = 0; i < oArg.length; i++) {
		try {
			var re = new RegExp(sDrive[i], "gi");
			if (typeof MappedDrives[sDrive[i]] == "undefined") {
				sOut += oArg(i) + "\r\n";
			}
			else {
				sOut += oArg(i).replace(re, MappedDrives[sDrive[i]]) + "\r\n";
			}
		}
		catch (e) {
			//	invalid drive
		}
	}
	sOut = sOut.substr(0, sOut.length - 2);
	
	var d = (new Date()).valueOf();
	
	
	//	use MSIE -- works with IE8 but not with IE10?
	////	Durations (ms):	293,274,275,300
	//var objIE = new ActiveXObject("InternetExplorer.Application");
	//objIE.Navigate("about:blank");
	//objIE.document.parentWindow.clipboardData.setData("text", sOut);
	//
	//objIE.Quit();
	
	
	////	use clip.exe -- the command works in the CLI (admin or not), but doesn't seem to work here.
	////	Durations (ms):	
	//var WshShell = WScript.CreateObject("WScript.Shell");
	//WshShell.Run("cmd.exe /c echo \"" + sOut + "\" | clip", 0, true);
	//delete WshShell;
	
	
	//	use clip.exe -- this one flashes a command window, but it screams
	//	Durations (ms):	3, 0, 2, 2
	var WshShell = new ActiveXObject("WScript.Shell");
	var oClip = WshShell.Exec("clip");
	var oIn = oClip.stdIn;
	oIn.Write(sOut);
	oIn.Close();
	
	//WScript.Echo((new Date()).valueOf() - d);
}

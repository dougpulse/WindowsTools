//	When an object is dragged from Windows Explorer and dropped on something, 
//	the "something" receives a bit of text that is the full path of the object 
//	that was dragged.
//	
//	This script accepts a string as an argument.
//	
//	Intended use:  	Drop a folder on this script.
//					If Windows allows, a command line will be opened at this folder.
//	
//	Revision History:
//	Date		Developer	Change
//	2023-02-28	d. pulse	
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
	
	//var d = (new Date()).valueOf();
	
	////	use clip.exe -- this one flashes a command window, but it screams
	////	Durations (ms):	3, 0, 2, 2
	//var WshShell = new ActiveXObject("WScript.Shell");
	//var oClip = WshShell.Exec("clip");
	//var oIn = oClip.stdIn;
	//oIn.Write(sOut);
	//oIn.Close();
	
}

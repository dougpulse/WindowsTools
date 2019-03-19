
var oArg = WScript.Arguments;
var sOut = "";
var arrOut = new Array();
var oFSO = new ActiveXObject("Scripting.FileSystemObject");


if (oArg.length == 1) {
	if (oFSO.FolderExists(oArg(0))) {
		ListFolderContents(oFSO.GetFolder(oArg(0)));
		
		sOut = arrOut.join("\r\n");
		
		//var objIE = new ActiveXObject("InternetExplorer.Application");
		//objIE.Navigate("about:blank");
		//objIE.document.parentWindow.clipboardData.setData("text", sOut);
		//
		//objIE.Quit();
	
		//	use clip.exe -- this one flashes a command window, but it screams
		//	Durations (ms):	3, 0, 2, 2
		var WshShell = new ActiveXObject("WScript.Shell");
		var oClip = WshShell.Exec("clip");
		var oIn = oClip.stdIn;
		oIn.Write(sOut);
		oIn.Close();
		
		WScript.Echo("Done");
	}
	else {
		WScript.Echo("The argument must be a folder.");
	}
}
else {
	WScript.Echo("There must be exactly one argument.");
}

function ListFolderContents(oFolder) {
	var files = new Enumerator(oFolder.Files);
	for (; !files.atEnd(); files.moveNext()) {
		arrOut.push(files.item().Path);
	}
	
	var folders = new Enumerator(oFolder.SubFolders);
	for (; !folders.atEnd(); folders.moveNext()) {
		ListFolderContents(folders.item());
	}
}

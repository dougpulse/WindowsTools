//	When an object is dragged from Windows Explorer and dropped on something, 
//	the "something" receives a bit of text that is the full path of the object 
//	that was dragged.
//	
//	This script accepts a string as an argument.
//	
//	Intended use:  	Drop a folder on this script.  The contents of the 
//					folder will be extracted from Windows (similar to  
//					the dir command) and the results will be placed 
//					on the clipboard.
//	

var oFSO = new ActiveXObject("Scripting.FileSystemObject");

var arrFiles = new Array();
arrFiles.push("Folder\tFile Name\tSize (bytes)\tDate Created\tDate Modified");

var oArg = WScript.Arguments;
var sArg = "";


if (oArg.length != 1) {
	//	no folder dropped
	WScript.Echo("Please use only one folder.");
}
else {
	sArg = oArg(0);
	getFSItem(sArg);
}

function getFSItem(s) {
	if (oFSO.FolderExists(s)) {
		getDir(oFSO.GetFolder(s));
	}
	else {
		//	no folder dropped
		WScript.Echo("Input must be a folder.");
	}
}

function getDir(oFld) {
	var eFile = new Enumerator(oFld.Files);
	var mod = "";
	var create = "";
	var dc = new Date();
	var dm = new Date();
	for (; !eFile.atEnd(); eFile.moveNext()) {
		with (eFile.item()) {
			dc = new Date(DateCreated)
			create = dc.getFullYear() + "-" + (dc.getMonth() + 1) + "-" + dc.getDate() + " " + dc.getHours() + ":" + dc.getMinutes() + ":" + dc.getSeconds();
			dm = new Date(DateLastModified)
			mod = dm.getFullYear() + "-" + (dm.getMonth() + 1) + "-" + dm.getDate() + " " + dm.getHours() + ":" + dm.getMinutes() + ":" + dm.getSeconds();
			arrFiles.push(oFld.Path + "\t" + Name + "\t" + Size + "\t" + create + "\t" + mod);
		}
	}
	var eFld = new Enumerator(oFld.SubFolders);
	for (; !eFld.atEnd(); eFld.moveNext()) {
		getDir(eFld.item());
	}
}

var WshShell = new ActiveXObject("WScript.Shell");
var oClip = WshShell.Exec("clip");
var oIn = oClip.stdIn;
oIn.WriteLine(arrFiles.join("\r\n"));
oIn.Close();

WScript.Echo("Done");

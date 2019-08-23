Adding "New" files of specific types to a folder
================================================

Too add file types to the New menu (context sensitive on a folder in Windows Explorer):


Run regedit.
Expand HKEY_CLASSES_ROOT.
Find the file extension for which you want to add an item to the New menu.
Add a key named ShellNew.
In ShellNew:
	Add a string value named NullFile.
	Add a string value named FileName and set the value to the location of the seed file.

See https://www.askvg.com/how-to-add-remove-items-from-new-menu-in-windows/ for more details.


Or create a *.reg file like below and double-click on it.



htm.reg
---

```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\.bat\ShellNew]
"NullFile"=""
"FileName"="C:\\tools\\FileTypes\\seed.bat"
```


This folder contains some samples.


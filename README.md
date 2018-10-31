WindowsTools
============

### Some handy tools for use in Microsoft Windows
Copy to a folder in Windows.  I usually create a folder in under Public Documents.  
Tested on Windows 7 and 10 in specific environments.  
Use at your own risk.  

In Windows 10, the default location of the SendTo folder is here:  C:\Users\<username>\AppData\Roaming\Microsoft\Windows\SendTo  

**Send To.js**
- Install:  Double-click this to add it to the Send To list.  (Running this script with no arguments causes it to install itself.)
- Usage (preferred):  Select one or more files or folders, right-click | Send To | Send To to put them on the Send To list.
- Usage (alternate):  Drag one or more files or folders onto this to add them to the Send To list.

**UNC Path.js**
Produces the UNC path to the selected folder or file.  This is useful when communicating file locations with users who may have resources mapped to different drive letters than you do.
- Install:  Right-click | Send To | Send To (see above)
- Usage (preferred):  Select the files or folders you want the paths of, right-click | Send To | UNC Path, paste into text editor.
- Usage (alternate):  Drag one or more files or folders onto this, paste into text editor.

  
  

I usually don't do branching and merging in git.  Most of what I need is just pull and push (like SVN), so these tools work well for me:  
**pull.bat**
Pulls the remote repo to local repo.
- Install:  Right-click | Send To | Send To (see above)
- Usage:  Right-click | Send To | pull
- Note:  You may want to rename the shortcut (and maybe the bat file) "git pull" if you use more than one version-control product.

**push.bat**
Pushes changes in the local repo up to the remote repo.  
This asks for a commit message, then performs an add, commit, and push.  
- Install:  Right-click | Send To | Send To (see above)
- Usage:  Right-click | Send To | push
- Note:  You may want to rename the shortcut (and maybe the bat file) "git push" if you use more than one version-control product.


**tidy.bat**
Uses tidy.exe (http://tidy.sourceforge.net/) to make human-readable XML.  This is great for performing a diff between commits, especially if whatever is writing your XML tends to put everything on one line.
- Install:  Right-click | Send To | Send To (see above)
- Usage:  Right-click | Send To | tidy
- Note:  You may want to rename the shortcut (and maybe the bat file) "tidy xml" if you want to modify a copy it to tidy html.



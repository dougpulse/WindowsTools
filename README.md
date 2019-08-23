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

**LyncKillCTRLEnter.reg**
In Microsoft Outlook, CTRL+Enter is used to send the message.  In a Lync (Skype for Business) message window, this begins a "phone call" to the user(s) you're chatting with.  Since I use Outlook a lot, I find I'm constantly "ringing" peoples' "phones" via Skype for Business.  I find it very frustrating.  
To disable this behavior, just run this reg file.

**DirSimple.js**
Lists the directory structure of the folder.  Outputs one entry per line.  Each entry includes the full path to the object.
- Install:  Right-click | Send To | Send To (see above)
- Usage (preferred):  Select the files or folders you want the paths of, right-click | Send To | UNC Path, paste into text editor or spreadsheet.
- Usage (alternate):  Drag a folder onto this, paste into text editor or spreadsheet.

**DirDetail.js**
Lists the directory structure of the folder.  Outputs one entry per line.  Each line shows the path to the file, the file name, file size, date created, and date modified.
- Install:  Right-click | Send To | Send To (see above)
- Usage (preferred):  Select the files or folders you want the paths of, right-click | Send To | UNC Path, paste into text editor or spreadsheet.
- Usage (alternate):  Drag a folder onto this, paste into text editor or spreadsheet.





### Git
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

**reset.bat**
Overwrites the local repo from the remote repo.   
- Install:  Right-click | Send To | Send To (see above)
- Usage:  Right-click | Send To | reset
- Note:  You may want to rename the shortcut (and maybe the bat file) "git reset" if you use more than one version-control product.


**tidy.bat**
Uses tidy.exe (http://tidy.sourceforge.net/) to make human-readable XML.  This is great for performing a diff between commits, especially if whatever is writing your XML tends to put everything on one line.
- Install:  Right-click | Send To | Send To (see above)
- Usage:  Select one or more files then:  Right-click | Send To | tidy
- Note:  You may want to rename the shortcut (and maybe the bat file) "tidy xml" if you want to modify a copy of it to tidy html.





### Incomplete/Quirky
These ones are not full-featured or do strange things like open Excel to display output.  But that could be modified.

**MSAD Groups per User.vbs**
VBScript that accepts one user name, queries MS Active Directory, and displays all of the groups of which that user is a member.
- Produces an error if the user name is not found.
- Outputs to Excel
- Usage:  Double-click, enter the user name

**MSAD Users per Group.vbs**
VBScript that accepts one group name, queries MS Active Directory, and displays all of the membership list.
- Produces an error if the user name is not found.
- Outputs to Excel
- Usage:  Double-click, enter the group name

**CompareFolders.bat**
Compares the directory listing of two folders.
- Usage:  Drag and drop two folders onto the file.
- Usage (alternate):  Run from the command line:
    CompareFolders.bat "First Folder" SomeOtherFolder

**FileTypes** (folder)
Shows how to create seed files for new documents.

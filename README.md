WindowsTools
============

### Some handy tools for use in Microsoft Windows
Copy to a folder in Windows.  The best way to do this is...
```
c:
cd %userprofile%\documents
git clone https://github.com/dougpulse/WindowsTools.git WindowsTools
```

Tested on Windows 7 and 10 in specific environments.  
Use at your own risk.  

In Windows 10, the default location of the SendTo folder is here:  
C:\Users\<username>\AppData\Roaming\Microsoft\Windows\SendTo  
%appdata%\Microsoft\Windows\SendTo  

#### Send To.js
- Install:  Double-click this to add it to the Send To list.  (Running this script with no arguments causes it to install itself.)
- Usage (preferred):  Select one or more files or folders, right-click | Send To | Send To to put them on the Send To list.
- Usage (alternate):  Drag one or more files or folders onto this to add them to the Send To list.

#### UNC Path.js

Produces the UNC path to the selected folder or file.  This is useful when communicating file locations with users who may have resources mapped to different drive letters than you do.
- Install:  Right-click | Send To | Send To (see above)
- Usage (preferred):  Select the files or folders you want the paths of, right-click | Send To | UNC Path, paste into text editor.
- Usage (alternate):  Drag one or more files or folders onto this, paste into text editor.

#### LyncKillCTRLEnter.reg

In Microsoft Outlook, CTRL+Enter is used to send the message.  In a Lync (Skype for Business) message window, this begins a "phone call" to the user(s) you're chatting with.  Since I use Outlook a lot, I find I'm constantly "ringing" peoples' "phones" via Skype for Business.  I find it very frustrating.  
To disable this behavior, just run this reg file.

#### DirSimple.js
Lists the directory structure of the folder.  Outputs one entry per line.  Each entry includes the full path to the object.
- Install:  Right-click | Send To | Send To (see above)
- Usage (preferred):  Select the files or folders you want the paths of, right-click | Send To | UNC Path, paste into text editor or spreadsheet.
- Usage (alternate):  Drag a folder onto this, paste into text editor or spreadsheet.

#### DirDetail.js
Lists the directory structure of the folder.  Outputs one entry per line.  Each line shows the path to the file, the file name, file size, date created, and date modified.
- Install:  Right-click | Send To | Send To (see above)
- Usage (preferred):  Select the files or folders you want the paths of, right-click | Send To | UNC Path, paste into text editor or spreadsheet.
- Usage (alternate):  Drag a folder onto this, paste into text editor or spreadsheet.

#### ShortKeys
Windows allows hotkeys.  For example, I use CTRL+ALT+X to open Excel.  This is done in the property of the shortcut.  I like to keep my hotkeys all in one place.
- Add a folder named hortkeys to `C:\Users\<username>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\`
- Add to that folder any shortcuts to which you want to assign hotkey combinations.
- For each shortcut, open *Properties*, go to the *Shortcut* tab and add the *Shortcut key:* combination you want to use.

#### NewFile
Based on FileTypes (see below), this creates a registry entry to enable you to set default contents for a new file of the given type when using the "New" item on the context-sensitive toolbar in Windows Explorer.  
This requires input which is a file path to a file named `seed.<extension>`.  (like seed.htm or seed.bat)  
It does nothing if the "new file" capability for the given extension already exists.  
`newfile.ps1` is called by `newfile.bat`, which is called from the shortcut `newfile` (.lnk) which is configured to "Run as administrator" (which is required because we're writing to the registry).  
- Install:
  - Adjust the *Target* and *Start in* properties of the "newfile" shortcut
  - Right-click on the shortcut named "newfile" | Send To | Send To
- Usage:  Right-click on the seed file | Send To | newfile | Yes (on the UAC challenge)

#### WriteToDBTable
Writes the contents of a CSV file to a SQL Server database on the local machine.  
It does nothing if the file is not a CSV.  
`WriteToDBTable.ps1` is called by `WriteToDBTable.bat`.
- Warnings:
  - Uses the *dbatools* PowerShell module.  Documentation regarding the workhorse behind this script: https://docs.dbatools.io/#Import-DbaCsv
  - Assumes SQL Server is running and available on the local machine.
  - Only CSV files are allowed in this version.
  - Regarding the table:
    - If the table exists, records will be appended.
      - Running this script on the same file twice will result in duplicate rows.  That causes problems for some actions.
    - If the table exists but has a different structure, there may be unexpected results.
    - If the table doesn't exist, one will be created using VARCHAR(MAX) as the data type for every column.
    - Creating a table with appropriate column names and data types and an auto-increment column is preferred.
- Install:
  - Open WriteToDBTable.ps1 and adjust as needed.
  - Right-click on WriteToDBTable.bat | Send To | Send To
- Usage:  Right-click on the data file (CSV) | Send To | WriteToDBTable


<br /><br />

### Git
I usually don't do branching and merging in git.  Most of what I need is just pull and push (like SVN), so these tools work well for me:  
#### pull.bat
Pulls the remote repo to local repo.
- Install:  Right-click | Send To | Send To (see above)
- Usage:  Right-click | Send To | pull
- Note:  You may want to rename the shortcut (and maybe the bat file) "git pull" if you use more than one version-control product.

#### push.bat
Pushes changes in the local repo up to the remote repo.  
This asks for a commit message, then performs an add, commit, and push.  
- Install:  Right-click | Send To | Send To (see above)
- Usage:  Right-click | Send To | push
- Note:  You may want to rename the shortcut (and maybe the bat file) "git push" if you use more than one version-control product.

#### reset.bat
Overwrites the local repo from the remote repo.   
- Install:  Right-click | Send To | Send To (see above)
- Usage:  Right-click | Send To | reset
- Note:  You may want to rename the shortcut (and maybe the bat file) "git reset" if you use more than one version-control product.


#### tidy.bat
Uses tidy.exe (http://tidy.sourceforge.net/) to make human-readable XML.  This is great for performing a diff between commits, especially if whatever is writing your XML tends to put everything on one line.
- Install:  Right-click | Send To | Send To (see above)
- Usage:  Select one or more files then:  Right-click | Send To | tidy
- Note:  You may want to rename the shortcut (and maybe the bat file) "tidy xml" if you want to modify a copy of it to tidy html.



<br /><br />

### Incomplete/Quirky
These ones are not full-featured or do strange things like open Excel to display output.  But that could be modified.

#### MSAD Groups per User.vbs
VBScript that accepts one user name, queries MS Active Directory, and displays all of the groups of which that user is a member.
- Produces an error if the user name is not found.
- Outputs to Excel
- Usage:  Double-click, enter the user name

#### MSAD Users per Group.vbs
VBScript that accepts one group name, queries MS Active Directory, and displays all of the membership list.
- Produces an error if the user name is not found.
- Outputs to Excel
- Usage:  Double-click, enter the group name

#### CompareFolders.bat
Compares the directory listing of two folders.
- Usage:  Drag and drop two folders onto the file.
- Usage (alternate):  Run from the command line:
    CompareFolders.bat "First Folder" SomeOtherFolder

#### FileTypes
(folder)
Shows how to create seed files for new documents.

#------------------------------
#Write-Host
#get input
$f = "C:\Users\pulsed\MyDocs\seed.htm"
#Write-Host $f

#is the input a valid file path?
if (Test-Path -Path $f) {
}
else {
    Write-Host "Invalid file path"
    exit
}


#find the last slash
$slashIndex = $f.LastIndexOf("\")
#Write-Host $slashIndex

#get the folder path
$path = $f.Substring(0, $slashIndex+1)
#Write-Host $path

#get the file.ext
$file = $f.Substring($slashIndex+1)
#Write-Host $file

#find the dot
$dotIndex = $file.LastIndexOf(".")
#Write-Host $dotIndex

#does the file name have 4 characters?
if ($dotIndex -ne 4) {
    Write-Host "wrong length"
    exit
}

#get the file name
$fname = $file.Substring(0, $dotIndex)
#Write-Host $fname

#is the file name "seed"?
if ($fname -ne "seed") {
    Write-Host "name must be seed"
    exit
}

#get the extension
$fext = $file.Substring($dotIndex+1)
#Write-Host $fext

if (Get-PSDrive HKCR -ErrorAction SilentlyContinue) {
}
else {
    New-PSDrive -name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
}
#does the registry entry already exist?
#Write-Host "Testing for HKCR:\.$fext\ShellNew"
#Test-Path "HKCR:\.$fext\ShellNew"


if (Test-Path "HKCR:\.$fext\ShellNew") {
    Write-Host ".$fext is already configured"
}
else {
    Write-Host ".$fext is not yet configured"
    New-Item -Path HKCR:\.$fext\ShellNew
    New-ItemProperty -Path HKCR:\.$fext\ShellNew -Name NullFile -PropertyType String -Value ""
    New-ItemProperty -Path HKCR:\.$fext\ShellNew -Name FileName -PropertyType String -Value $f
}

#Windows Registry Editor Version 5.00
#
#[HKEY_CLASSES_ROOT\.bat\ShellNew]
#"NullFile"=""
#"FileName"="C:\\tools\\FileTypes\\seed.bat"


#Write-Host
#------------------------------


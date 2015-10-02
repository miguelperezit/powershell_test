
$base64before ={# Variables

$user=[Environment]::UserName
$personalfolder =("\\domino.softonic.com\FILES\HomesES\" + $user)
$tempfolder="\\domino.softonic.com\FILES\Temp"
$mediafolder="\\domino.softonic.com\FILES\Media"
$softonicfolder="\\domino.softonic.com\FILES\Softonic"

# Connections

New-PSDrive -Name K -PSProvider FileSystem -Root $personalfolder -Description "Personal Folder" -Persist -ErrorAction SilentlyContinue

New-PSDrive -Name M -PSProvider FileSystem -Root $mediafolder -Description "Multimedia folder" -Persist -ErrorAction SilentlyContinue

New-PSDrive -Name T -PSProvider FileSystem -Root $tempfolder -Description "Multipurpose folder" -Persist -ErrorAction SilentlyContinue

New-PSDrive -Name Z -PSProvider FileSystem -Root $softonicfolder -Description "Softonic Files Folder" -Persist -ErrorAction SilentlyContinue
}

$command = 'dir "c:\program files" '
$base64prepared = [System.Text.Encoding]::Unicode.GetBytes($base64before)
$encodedCommand = [Convert]::ToBase64String($base64prepared)
#powershell.exe -encodedCommand
$encodedCommand
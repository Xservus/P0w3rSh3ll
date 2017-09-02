#play in the shadows with vssadmin and symbolic links
#this part requires a bit of manual work

$shadow = get-wmiobject win32_shadowcopy

$class=[WMICLASS]"root\cimv2:win32_shadowcopy"

$class.create("C:\", "ClientAccessible")

$shadow = get-wmiobject win32_shadowcopy

.\vssadmin.exe List Shadows #(you could use most likely use WMI to automated this)

#this is how to do it via WMI
$lastshadow = Get-WmiObject -query "Select * from win32_shadowcopy" | select -ExpandProperty DeviceObject -Last 1
$cmd_string = "mklink /d c:\shadows1 " + $lastshadow + "\"

Invoke-Command -ScriptBlock {& cmd /c $cmd_string}

#change the paths in line with the shadows created (ignore this as we've automated it now)
#Invoke-Command -ScriptBlock {& cmd /c "mklink /d c:\shadows \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy6\"}
Get-ChildItem C:\shadows1 -Recurse | get-filehash -Algorithm MD5 | Export-Csv c:\shadowfilehashes.csv -NoTypeInformation

#mklink /d c:\shadow \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy6\


#enumerate all drives with file systems and creat a hash doc (will not be able to hash all files as files are in use - use VSS method or offline disk
GET-WMIOBJECT –query “SELECT * from win32_logicaldisk where DriveType = '3'”| select -ExpandProperty DeviceID| Get-ChildItem -Recurse | get-filehash -Algorithm MD5 | Export-Csv c:\filehashes.csv -NoTypeInformation

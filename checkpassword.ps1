#checks if a password has been involved in a breach from haveIbeenpwned.com


$password = Read-Host "What is your password?"

$sha1 = New-Object System.Security.Cryptography.SHA1CryptoServiceProvider
$utf8 = new-object -TypeName System.Text.UTF8Encoding

$hash = [System.BitConverter]::ToString($sha1.ComputeHash($utf8.GetBytes($password)))

$hashurl = $hash -replace "-",""

write-host $hash
write-host $hashurl

$haveib33npw3d = "https://api.pwnedpasswords.com/pwnedpassword/" + $hashurl

write-host $haveib33npw3d

#set TLS1.2

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#invoke a direct request (this can be sniffed)
#Invoke-WebRequest -Uri $haveib33npw3d | Select-Object -ExpandProperty Content

#better to do a range find

$haveib33npw3dRange = "https://api.pwnedpasswords.com/range/" + $hashurl.SubString(0,5)

write-host $haveib33npw3dRange

$webhash = Invoke-WebRequest -Uri $haveib33npw3dRange

$webhash.StatusCode

if ($webhash.StatusCode -eq 200)

{

$hashes = $webhash | Select-Object -ExpandProperty Content

write-host $hashes

$locate = $hashurl.SubString(5)

write host "looking for " $locate

$test = $hashes -like "*" + $locate + "*"

write-host $test

#now find the hash

if($test -eq $TRUE)
{
write-host "Located Password in HaveIBeenPwn3d" -ForegroundColor Red

}
else
{write-host "Unable to locate password" -ForegroundColor Green
}
}

else
{
write-host "Unable to query haveIbeenpwned" -ForegroundColor Red

}






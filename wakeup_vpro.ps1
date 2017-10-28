#wakeup a list of vpro computers
#uses async jobs so you can wakeup computers en mass (tested 400 computers wakeup in ~5 minutes)

$creds = Get-Credential

$amtcreds = Write-AmtCredential -Username $creds.UserName -Password $creds.Password

$amtcreds = Read-AmtCredential


#read a file of known assets (do this it's fast)
$computers = get-content C:\amt\vpro_computers.txt



foreach ($computer in $computers){


$computer = $computer + ".rcp-net.com"


$time = Get-Date

$log = $time.ToString() + ",powering on computer," + $computer 

write-output $log| out-file c:\amt\forcelogs.txt -Append
write-host $computer


Start-Job -ScriptBlock { Invoke-AMTPowerManagement -Operation PowerOn -Credential $args[0] -Port 16993 -TLS -ComputerName $args[1] } -ArgumentList $amtcreds,$computer


}

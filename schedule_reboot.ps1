$servername = "server1"
$mailserver = "mailserver1"

register-ScheduledJob -Name systemReboot -ScriptBlock {
 
Restart-Computer -ComputerName $servername -Force -wait
 
Send-MailMessage -From email@address.com -To email@address.com -Subject "Rebooted" -SmtpServer $mailserver
 
} -Trigger (New-JobTrigger -At "28/10/2017 8:00pm" -Once) -ScheduledJobOption (New-ScheduledJobOption -RunElevated) -Credential (Get-Credential)

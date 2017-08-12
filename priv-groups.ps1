#Quick and dirty priv group enumeration and dump to csv
#could be more efficient by building an array and looping
#left as one liners to allow for parent child or group customisation


Get-ADGroupMember -Identity "Administrators" -AuthType Negotiate -Recursive | select -Property * | Export-Csv -NoClobber "Builtin-admins.csv"
Get-ADGroupMember -Identity "Domain Admins" -AuthType Negotiate -Recursive| select -Property * | Export-Csv -NoClobber "Domain Admins.csv"
Get-ADGroupMember -Identity "Enterprise Admins" -AuthType Negotiate -Recursive| select -Property * | Export-Csv -NoClobber "Enterprise Admins.csv"
Get-ADGroupMember -Identity "Schema Admins" -AuthType Negotiate -Recursive| select -Property * | Export-Csv -NoClobber "Schema admins.csv"
Get-ADGroupMember -Identity "Backup Operators" -AuthType Negotiate -Recursive| select -Property * | Export-Csv -NoClobber "backup Operators.csv"
Get-ADGroupMember -Identity "Server Operators" -AuthType Negotiate -Recursive| select -Property * | Export-Csv -NoClobber "Server Operators.csv"
Get-ADGroupMember -Identity "Account Operators" -AuthType Negotiate -Recursive| select -Property * | Export-Csv -NoClobber "Acount Operators.csv"
Get-ADGroupMember -Identity "Cert Publishers" -AuthType Negotiate -Recursive| select -Property * | Export-Csv -NoClobber  "Cert Publishers.csv"
Get-ADGroupMember -Identity "DHCP Administrators" -AuthType Negotiate -Recursive| select -Property * | Export-Csv -NoClobber "DHCP administrators.csv"
Get-ADGroupMember -Identity "DnsAdmins" -AuthType Negotiate -Recursive| select -Property * | Export-Csv -NoClobber "Dns admins.csv"
Get-ADGroupMember -Identity "Group Policy Creator Owners" -AuthType Negotiate -Recursive| select -Property * | Export-Csv -NoClobber "Group Policy Creator owners.csv"

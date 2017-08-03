#########################################################
# Service Account Enumeration Copyright (c) Xservus Limited
# Author: Daniel Card
##########################################################
#################
# Date: 25/03/2017
# Version 2.1
# Description: This script scans active directory for Windows Server Objects then uses wmi connection to enumerate servies, IIS app pools and scheduled tasks created by the AT command.
#
#################





$computers = Get-ADComputer -Filter {OperatingSystem -Like 'Windows Server*'} -Property * 

$computers | Export-Csv -Path computers.csv -append -NoTypeInformation
$ping = new-object system.net.networkinformation.ping

 $c = 0

ForEach($computer in $computers)


{
#write-host $computer.name
write-host "Computer Name: " $computer.DNSHostName
  
  
  #ping the host


  try{
  $pfail = 0
   $ping = (Test-Connection -ComputerName $computer.DNSHostName -Count 2  | measure-Object -Property ResponseTime -Average).average 
   }
   Catch{
   $pfail = 1
   
   }
        
    $response = ( $ping -as [int])
    write-host "ICMP Ping Response Time: " $response

    
    #if ping is successful then do a service inventory
    if($pfail -eq 0){

    #now check wmi connection
    write-host "check for wmi"
     write-host "Checking WMI connection"
    
     $testwmi = 0

  Try{
  $test = Get-WmiObject win32_operatingsystem -computername:$computer.DNSHostName
  }
  Catch
  {
  $testwmi = 1

  write-host "Error"
  }
  Finally
  {
  write-host $testwmi
  if($test.name.Length -ge 1)
  { 
  $testwmi = 0
  }
  else
  {$testwmi = 1
  }
  
    if($testwmi -eq 0)
    {

    
    write-host "Starting Service Inventory"
    $c = $c + 1
    Get-WmiObject win32_service -computername:$computer.DNSHostName -Property * |  Format-Table DisplayName,StartName,State -Wrap -Auto

    #use this line for seperate output files per server
    
    #$file = $computer.Name + ".html"
        
    #get services
    


    Get-WmiObject win32_service -computername:$computer.DNSHostName -Property * | Export-Csv -Path services.csv -append -NoTypeInformation

    #get patch data


    Get-WmiObject Win32_QuickFixEngineering -computername:$computer.DNSHostName -Property * | Export-Csv -Path qfe_patches.csv -append -NoTypeInformation

    #get scheduled tasks
    
    Get-WmiObject Win32_ScheduledJob -computername:$computer.DNSHostName -Property * | Export-Csv -Path scheduled_tasks.csv -append -NoTypeInformation


    #get IIS data

              Get-WmiObject IIsWebVirtualDirSetting -Namespace "root\MicrosoftIISv2"  -computername:$computer.DNSHostName -Property * | Export-Csv -Path iis_config.csv -append -NoTypeInformation
        
            
    Get-WmiObject IIsApplicationPoolSetting -Namespace "root\MicrosoftIISv2"  -computername:$computer.DNSHostName -Property * | Export-Csv -Path iis_app_pools.csv -append -NoTypeInformation


    #get winndows feature data

    Get-WmiObject Win32_OptionalFeature -Namespace "root\CIMv2"  -computername:$computer.DNSHostName -Property * | Export-Csv -Path windows_features.csv -append -NoTypeInformation

   

    #get windows server roles

    Get-WmiObject Win32_ServerFeature -Namespace "root\CIMv2"  -computername:$computer.DNSHostName -Property * | Export-Csv -Path windows_roles.csv -append -NoTypeInformation

    #new feaure request
    #check if winndows firewall is enabled

    $Reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine',$computer.DNSHostName)
    $RegKey= $Reg.OpenSubKey("SYSTEM\\CurrentControlSet\\Services\\SharedAccess\\Parameters\\FirewallPolicy\\DomainProfile")
    $firewalld = $RegKey.GetValue("EnableFirewall")
    write-host "firewall checking" $computer.DNSHostName
    write-host "firewall status for computer: " $computer.DNSHostName "," $firewalld
    $firevar = $computer.DNSHostName + "," + $firewalld 
    $firevar | Out-File firewall.csv -Append

    #$firewall_status = [system.String]::Join($computer.DNSHostName, " " + $firewalld)
    #$firewall_status | 

    #$firewall_status |  Export-Csv -Path windows_firewall.csv -append -NoTypeInformation
    #otherwise log unable to connecto to target
    }
    else
    {
    write-host "Failed to connect to server : " $computer.DNSHostName
    }

    

}
}
}

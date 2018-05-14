#created by Daniel Card
#14/05/2018
#Quick and Dirty Scanner for SMB Version
#Hotfix enumeration does not always work or multiple reboots are required so created a quick scanning script

$computers = Get-ADComputer -Filter {OperatingSystem -Like 'Windows Server*'}


foreach($computer in $computers){

write-host "Name: " $computer.Name
write-host "LDAP Path: " $computer

$SMBv1Version = Get-WmiObject CIM_Datafile -ComputerName $computer.DNSHostName -Filter "Name='c:\\windows\\system32\\Drivers\\srv.sys'"

write-host "c:\windows\system32\drivers\srv.sys Version = " $SMBv1Version.Version

#check sub version for Windows 7 or Server 2008 R2
if($SMBv1Version.Version.ToString() -like "6.1.*"){


write-host "Server 2008 R2 or Windows 7 Identified" -ForegroundColor DarkRed
    if($SMBv1Version.Version.ToString() -lt "6.1.7601.23689"){

    write-host "Vulnerable to EternalBlue - Reccomend you patch MS17-010 immediatley" -ForegroundColor Red

    }

}

#check sub version for Windows 2012
if($SMBv1Version.Version.ToString() -like "6.2.*"){


write-host "Windows 2012 Identified" -ForegroundColor DarkRed
    if($SMBv1Version.Version.ToString() -lt "6.2.9200.2209"){

    write-host "Vulnerable to EternalBlue - Reccomend you patch MS17-010 immediatley" -ForegroundColor Red

    }

}

#check sub version for Windows 2012 R2 or Windowws 8.1
if($SMBv1Version.Version.ToString() -like "6.3.*"){


write-host "Windows 2012 R2 or Windowws 8.1 Identified" -ForegroundColor DarkRed
    if($SMBv1Version.Version.ToString() -lt "6.3.9600.18604"){

    write-host "Vulnerable to EternalBlue - Reccomend you patch MS17-010 immediatley" -ForegroundColor Red

    }

}

#check sub version for Windows 10 or Server 2016
if($SMBv1Version.Version.ToString() -like "10.0.*"){


write-host "Windows Windows 10 or Server 2016 Identified" -ForegroundColor DarkRed
    if($SMBv1Version.Version.ToString() -lt "10.0.10240.17319"){

    write-host "Vulnerable to EternalBlue - Reccomend you patch MS17-010 immediatley" -ForegroundColor Red

    }

}



}

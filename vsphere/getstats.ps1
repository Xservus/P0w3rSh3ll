#Main Variables 
$sVCentre = "VC IP" 
$sVCUser = "administrator@domain" 
$sVCPwd = "password" 
$strVMWildCard = "*"
 $strCSVName = "Stats-AvgVMDiskWriteStatsWorkingday"
 $strCSVLocation = "c:\"
$metrics = "virtualDisk.totalWriteLatency.average","virtualDisk.totalReadLatency.average",
    "virtualDisk.numberReadAveraged.average","virtualDisk.numberWriteAveraged.average",
    "virtualDisk.read.average","virtualDisk.write.average"
 # define the start and finish times for a working day. $today9am = (Get-Date -Hour 9 -Minute 0 -Second 0)
$today5pm = (Get-Date -Hour 17 -Minute 0 -Second 0)
$intStartDay = -1
$intEndDay = -1
## Begin Script

#Connect to VC
Connect-VIServer $sVCentre -User $sVCUser -Password $sVCPwd -ea silentlycontinue
$arrVMs = Get-VM | where-object {$_.Name -like $strVMWildCard}
$stats = Get-Stat -Entity $arrVMs -Stat $metrics -Start $today9am.AddDays($intStartDay) -Finish $today5pm.AddDays($intEndDay)

# group the data and collate the stats into averages for the day.
$groups = $stats | Group-Object -Property {$_.Entity, $_.MetricId, $_.Instance}
$report = $groups | % {
    New-Object PSObject -Property @{
        Description = $_.Group[0].Description
        Entity = $_.Group[0].Entity
        EntityId = $_.Group[0].EntityId
        Instance = $_.Group[0].Instance
        MetricId = $_.Group[0].MetricId
        Timestamp = $_.Group[0].Timestamp.Date.AddHours($_.Group[0].Timestamp.Hour)
        Unit = $_.Group[0].Unit
        Value = [math]::Round(($_.Group | Measure-Object -Property Value -Average).Average, 2)
    }
}
#Exporting the report to a CSV file.
$strCSVSuffix = (get-date).toString('yyyyMMddhhmm')
$strCSVFile = $strCSVLocation + $strCSVName + "_" + $strCSVSuffix + ".csv"$report | Export-Csv $strCSVfile -NoTypeInformation -UseCulture

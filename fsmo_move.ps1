#get the fsmo roles

Get-ADForest | Select SchemaMaster, DomainNamingMaster | FL
Get-ADDomain | Select PDCEmulator, RIDMaster, InfrastructureMaster | FL


#now move them

#ask operator what the target should be

$target = read-host("Please enter target domain controller name")

#sleep for a bit
start-sleep -Seconds 30

#check the roles again

Move-ADDirectoryServerOperationMasterRole -Identity $target -OperationMasterRole SchemaMaster, DomainNamingMaster

Move-ADDirectoryServerOperationMasterRole -Identity $target -OperationMasterRole  PDCEmulator, RIDMaster, InfrastructureMaster

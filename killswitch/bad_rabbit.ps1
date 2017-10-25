#script to disable bad rabbit from being able to encrypt data
#fast write - could be improved
#not tested with sample yet
# thanks to https://twitter.com/0xAmit for the intel :)

#create the blocking files

add-content "c:\windows\infpub.dat" "BadRabbit Killswitch"
add-content "c:\windows\cscc.dat" "BadRabbit Killswitch"

#disable inheritance

$acl = Get-ACL -Path "c:\windows\infpub.dat"
$acl.SetAccessRuleProtection($True, $True)
Set-Acl -Path "c:\windows\infpub.dat" -AclObject $acl

$acl = Get-ACL -Path "c:\windows\cscc.dat"
$acl.SetAccessRuleProtection($True, $True)


#remove all perms

 $acl=get-acl "c:\windows\infpub.dat"

 foreach ($access in $acl.access){

  $acl.RemoveAccessRule($access)

 }

  $acl=get-acl "c:\windows\cscc.dat"

 foreach ($access in $acl.access){

  $acl.RemoveAccessRule($access) 

 }

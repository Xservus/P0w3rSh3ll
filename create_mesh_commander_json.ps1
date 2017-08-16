#helps if you need to create a JSON file if you need to use mesh commander
#you need the change the info for username, pass, cert hash and certificate strings

$computerlist = get-content .\new_7040.txt

$length = $computerlist.Length

$count = 0

add-content mesh.json "{"
add-content mesh.json  """webappversion"": ""0.4.3"","

add-content mesh.json   """computers"": ["

foreach ($computer in $computerlist)

{
$count = $count + 1

write-host $computer

$name= """name"": ""$computer"","



$host1= """host"": ""$computer"","

$tags= """tags"": """","
$user= """user"": ""yyyyy"","

$pass= """pass"": ""xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"""



$tls=  """tls"": 1,"
$tlscerthash= """tlscerthash"": ""xxxxxxxxxxxxxx"","

$tlscert= """tlscert"":  ""xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"","
$ver= """ver"": ""11.0.26"","
$pstate= """pstate"": ""2"","
$pmode= """pmode"": ""1"","
$date= """date"":  ""2017-08-10T10:51:26.094Z"""

#

add-content mesh.json "{"
Add-Content mesh.json $name
Add-Content mesh.json $host1
Add-Content mesh.json $tags
Add-Content mesh.json $user
Add-Content mesh.json $pass
Add-Content mesh.json $tls
Add-Content mesh.json $tlscerthash
Add-Content mesh.json $tlscert
Add-Content mesh.json $ver
Add-Content mesh.json $pstate
Add-Content mesh.json $pmode
Add-Content mesh.json $date

if ($count -ne $length) 
{

add-content mesh.json "},"




}

else
{
add-content mesh.json "}"
}

}

add-content mesh.json   "]"
add-content mesh.json   "}"

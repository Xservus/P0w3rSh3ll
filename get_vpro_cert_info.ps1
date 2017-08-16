#this is in dev and really crude but will get vpro certs based on a list of computernames in text file

$computerlist = get-content .\new_7040.txt

$webclient = New-Object Net.WebClient

$webclient | get-member

foreach ($computer in $computerlist)
{

$url = "https://" + $computer + ":16993"

write-host URL =  $url


$return = $webclient.DownloadString($url)

#shows the html return if you are in to that kinda thing ;)
#write-host $return

#probably should implment some catching logic before we just blast away....


$servicePoint = [System.Net.ServicePointManager]::FindServicePoint($url)

#$servicePoint | get-member

write-host $servicePoint.Certificate.Subject
write-host $servicePoint.Certificate.Issuer
write-host $servicePoint.Certificate.Handle


$SSL_THUMBPRINT = $servicePoint.Certificate.GetCertHashString()

$SSL_THUMBPRINT1 = $servicePoint.Certificate.GetCertHash()

$SSL_THUMBPRINT2 = $servicePoint.Certificate.GetPublicKeyString()

$SSL_THUMBPRINT3 = $servicePoint.Certificate.GetPublicKey()

$SSL_THUMBPRINT4 = $servicePoint.Certificate.GetType()

$SSL_THUMBPRINT5 = $servicePoint.Certificate.GetEffectiveDateString()

$SSL_THUMBPRINT6 = $servicePoint.Certificate.GetExpirationDateString()



write-host "cert hash string :" $SSL_THUMBPRINT
write-host "cert hash :" $SSL_THUMBPRINT1
write-host "publickeystring :" $SSL_THUMBPRINT2
write-host "publickey : " $SSL_THUMBPRINT3
write-host "Type :" $SSL_THUMBPRINT4
write-host "Start Date :" $SSL_THUMBPRINT5
write-host "Expiration Date :" $SSL_THUMBPRINT6
}


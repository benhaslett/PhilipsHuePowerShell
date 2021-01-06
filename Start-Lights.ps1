
$config = Import-LocalizedData -filename config.psd1
$bridge = ("https://" + $config.ip)
$user = $config.user

#Invoke-WebRequest "$bridge/debug/clip.html"
$data = @{"devicetype" = "Beast"} | convertto-json
Invoke-WebRequest "$bridge/api" -Method Post -body $data -SkipCertificateCheck

$lights = (Invoke-WebRequest "$bridge/api/$user/lights" -SkipCertificateCheck).content | convertfrom-json

$data = @{"on" = $true} | convertto-json
Invoke-WebRequest "$bridge/api/$user/lights/3/state" -Method put -Body $data -SkipCertificateCheck

$data = @{"on" = $false} | convertto-json
Invoke-WebRequest "$bridge/api/$user/lights/3/state" -Method put -Body $data -SkipCertificateCheck


(Invoke-WebRequest "$bridge/api/$user/groups" -SkipCertificateCheck).content 

$data = @{"on" = $true} | convertto-json
Invoke-WebRequest "$bridge/api/$user/groups/3/action" -Method put -Body $data -SkipCertificateCheck

$data = @{"on" = $false} | convertto-json
Invoke-WebRequest "$bridge/api/$user/groups/3/action" -Method put -Body $data -SkipCertificateCheck


$data = @{"bri" = 128} | convertto-json
Invoke-WebRequest "$bridge/api/$user/groups/3/action" -Method put -Body $data -SkipCertificateCheck



$config = Import-LocalizedData -filename config.psd1
$bridge = ("https://" + $config.ip)
$user = $config.user


#Use this to create an API user
#It'll error until you press the pair button the HueBridge
#$data = @{"devicetype" = "Computer"} | convertto-json
#Invoke-WebRequest "$bridge/api" -Method Post -body $data -SkipCertificateCheck

#Use this to get a list of lights
$lights = (Invoke-WebRequest "$bridge/api/$user/lights" -SkipCertificateCheck).content | convertfrom-json

$data = @{"on" = $true} | convertto-json
Invoke-WebRequest "$bridge/api/$user/lights/3/state" -Method put -Body $data -SkipCertificateCheck

$data = @{"on" = $false} | convertto-json
Invoke-WebRequest "$bridge/api/$user/lights/3/state" -Method put -Body $data -SkipCertificateCheck

#Use this to get a list of rooms
(Invoke-WebRequest "$bridge/api/$user/groups" -SkipCertificateCheck).content 

$data = @{"on" = $true} | convertto-json
Invoke-WebRequest "$bridge/api/$user/groups/3/action" -Method put -Body $data -SkipCertificateCheck

$data = @{"on" = $false} | convertto-json
Invoke-WebRequest "$bridge/api/$user/groups/3/action" -Method put -Body $data -SkipCertificateCheck


$data = @{"bri" = 128} | convertto-json
Invoke-WebRequest "$bridge/api/$user/groups/3/action" -Method put -Body $data -SkipCertificateCheck


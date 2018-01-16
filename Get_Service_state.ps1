$service = Get-WmiObject -Class Win32_Service -Filter "Name='MpsSvc'"
return $service.state
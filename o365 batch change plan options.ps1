$UPNs = Get-Content "c:\temp\visio.txt"
foreach ($upn in $UPNs){

$LO = New-MsolLicenseOptions -AccountSkuId "LDZLV:VISIOCLIENT" -DisabledPlans "ONEDRIVE_BASIC"
Set-MsolUserLicense -UserPrincipalName $upn -LicenseOptions $LO 

} 
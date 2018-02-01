Get all available plan packages 
Get-MsolAccountSku


get all my plans 

(Get-MsolUser -UserPrincipalName livmanir@ldz.lv).Licenses.ServiceStatus
https://docs.microsoft.com/en-us/office365/enterprise/powershell/disable-access-to-services-with-office-365-powershell

export all visio users to temp txt file
Get-MsolUser -All | Where-Object {($_.licenses).AccountSkuId -match "VISIOCLIENT"}  |select UserPrincipalName,Licenses| Export-Csv -Encoding Unicode –Path c:/temp/visioALL.csv


get all users from file and remove onedrive basic from visio package for each user
$UPNs = Get-Content "c:\temp\visiotest.txt"
foreach ($upn in $UPNs){

$LO = New-MsolLicenseOptions -AccountSkuId "LDZLV:VISIOCLIENT" -DisabledPlans "ONEDRIVE_BASIC"
Set-MsolUserLicense -UserPrincipalName $upn -LicenseOptions $LO 

} 
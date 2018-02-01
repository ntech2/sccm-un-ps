$UPNs = Get-Content "c:\temp\visio.txt"
foreach ($upn in $UPNs){

(((Get-MsolUser -UserPrincipalName $upn).licenses).servicestatus) |Where-Object {($_.licenses).ServicePlan -match "ONEDRIVE_BASIC"} |select $upn, ServicePlan, ProvisioningStatus| Export-Csv -Encoding Unicode –Path c:/temp/1drivebasicALL.csv

} 

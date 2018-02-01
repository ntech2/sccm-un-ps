﻿Get-MsolUser -All | Where-Object {($_.licenses).ServicePlan -match "ONEDRIVE_BASIC"}  |select UserPrincipalName, ServicePlan, ProvisioningStatus| Export-Csv -Encoding Unicode –Path c:/temp/1drivebasicALL.csv
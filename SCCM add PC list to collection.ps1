Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
Set-Location LDZ:


Get-Content "C:\TEMP\CollectionMembers.txt" | foreach { Add-CMDeviceCollectionDirectMembershipRule -CollectionID "LDZ003B9" -ResourceID (Get-CMDevice -Name $_).ResourceID }
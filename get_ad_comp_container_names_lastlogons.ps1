$pcs = Get-Content -Path "C:\temp\compContPCLIST.txt"

foreach ($pc in $pcs)
{
write-host "Trying $pc"
Get-WmiObject -Class Win32_NetworkLoginProfile -ComputerName $pc | 
Sort-Object -Property LastLogon -Descending | 
Select-Object -Property * -First 1 | 
Where-Object {$_.LastLogon -match "(\d{14})"} | 
Foreach-Object { New-Object PSObject -Property @{ Name=$_.Name;LastLogon=[datetime]::ParseExact($matches[0], "yyyyMMddHHmmss", $null)}} | Export-Csv -Path c:\temp\compContainerReport.csv -Append
write-host "$pc donezo!"
}



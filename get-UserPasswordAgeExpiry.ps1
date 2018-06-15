$date = Get-Date -format dd.MM.yyyy.
Import-Module ActiveDirectory
<#
$Currentuser =Get-WmiObject –Class Win32_ComputerSystem | Select-Object UserName
$Currentuser = $Currentuser | Select-Object username -ExpandProperty *
$Currentuser = $Currentuser.split("\")
$Currentuser = $Currentuser[1]
$Currentuser = "grebezse" #>

$users = "grebezse","livmanir","samsoe01","liepid02","baronsr","zirnovsa","kukulei","jurkoa01","zebergsa"
cls
foreach($user in $users){

$user = get-aduser -identity $user -Properties *|select Name,SamAccountName,PasswordLastSet,PasswordNeverExpires,PasswordExpired,Memberof
$name = $user.samaccountname
$maxPasswordAge = (Get-ADDefaultDomainPasswordPolicy).MaxPasswordAge
$passwordsetdate = $user.PasswordLastSet

$oneyear = $false
$memberof = $user.memberof
  $memberof |foreach { if ($_ -match "FGP_VienuGaduParole"){[timespan]$maxPasswordAge = "365.00:00:00"}}
  

    $expireson = $passwordsetdate + $maxPasswordAge
    $today = $date
    $daystoexpire = (New-TimeSpan -Start $today -End $Expireson).Days
        
    
    $messageDays = $daystoexpire

    if (($messageDays) -ge "1")
    {
        $messageDays = "pēc " + "$daystoexpire" + " dienām(-s)."
    }
    elseif((($messageDays) -lt "0") -and ($user.PasswordNeverExpires -eq $false))
    {
        $messageDays = "beigusies"
    }
    elseif((($messageDays) -lt "0") -and ($user.PasswordNeverExpires -eq $true))
    {
        $messageDays = "nekad"
    }
    else
    {
        $messageDays = "šodien"
    }
    $name = $user.samaccountname
    Write-Host "Parole lietotājam $name beidzas: $messageDays - $expireson"
    }


  
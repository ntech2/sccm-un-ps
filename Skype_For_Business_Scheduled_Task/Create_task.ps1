$OS = (Get-CimInstance Win32_OperatingSystem).Caption

#Create LDz folder if it doesn't exist and copy StartSkype.vbs to it
$Path = "C:\Windows\LDz"
$PathExists = Test-Path $Path
if ($PathExists -eq $True) {
    Copy-Item ".\vbs\StartSkype.vbs" -Destination "C:\Windows\LDz" -Force 
}
Else { 
    New-Item -ItemType Directory -Path "C:\Windows\LDz"
    Copy-Item ".\vbs\StartSkype.vbs" -Destination "C:\Windows\LDz" -Force
}

$user = Get-WMIObject -class Win32_ComputerSystem | select username -ExpandProperty username

if ($OS -like "Microsoft Windows 10*") {
    ipmo ScheduledTasks

    #Create new scheduled task that launches StarSkype.vbs file
    $action = New-ScheduledTaskAction -Execute 'wscript.exe' -Argument '"C:\Windows\LDz\StartSkype.vbs"'
    $trigger = Get-CimClass "MSFT_TaskRegistrationTrigger" -Namespace "Root/Microsoft/Windows/TaskScheduler"
    Register-ScheduledTask -Action $action -Trigger $trigger -User $user -TaskName "StartSkype" -Description "Start Skype for Business if it's not running"

    #Modify the scheduled task to set repetition of 15 minutes indefinitely
    $Task = Get-ScheduledTask -TaskName "StartSkype"
    $Task.Triggers.Repetition.Interval = "PT15M"
    $Task | Set-ScheduledTask

}
Else {
    $env:user1=$user
    cmd.exe /c "Create_Skype_scheduled_task.bat"
}
 
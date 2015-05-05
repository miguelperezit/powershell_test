$Station =  hostname
$yesterday = (Get-Date) - (New-TimeSpan -day 900)
$Global:ObjectResults = @()

function Create-BootUpObject($XML,$Station) { 
    foreach ($Object in @($XML.Event.Eventdata)) { 
        $PSObject = New-Object PSObject 
        $PSObject | Add-Member NoteProperty Station $Station
        foreach ($Property in @($Object.Data)) { 
            $PSObject | Add-Member NoteProperty $Property.Name $Property."`#text"
        } 
        #$PSObject | ft Station,BootStartTime
        $Global:ObjectResults += $PSObject 
    } 
} 
if (Test-Connection $Station -count 1 -quiet)
	{
	$Events = Get-WinEvent -ComputerName $Station -FilterHashtable @{logname="Microsoft-Windows-Diagnostics-Performance/Operational"; id=100; StartTime=$yesterday}
   
    foreach ($Event in $Events){
        
    	$EventXML = [xml]$Event.ToXml()
            
            if ($EventXML)
            {
               Create-BootUpObject $EventXML $Station

            }
        }
  
    }
$Global:ObjectResults | Select-Object BootStartTime,BootTime,MainPathBootTime,BootPostBootTime,BootDriverInitTime,BootDevicesInitTime,BootCriticalServicesInitTime,BootUserProfileProcessingTime,BootMachineProfileProcessingTime,BootExplorerInitTime,BootNumStartupApps,WinLogonStartTimeMS,OtherLogonInitActivityDuration,UserLogonWaitDuration,BootPrefetchBytes | Export-Csv \\172.20.60.250\swaltiris\Logs\performance\CSV\$Station.csv -Delimiter ";"
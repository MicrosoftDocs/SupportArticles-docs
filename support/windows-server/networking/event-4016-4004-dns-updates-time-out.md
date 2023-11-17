---
title: Event IDs 4016 and 4004 when DNS updates time out
description: Helps resolve an issue in which Event IDs 4016 and 4004 are logged when DNS can't enumerate AD-integrated zones or create/write records in zones.
ms.date: 11/17/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, ANRATH, tfairman, v-lianna
ms.custom: sap:dns, csstroubleshoot, ikb2lmc
ms.technology: networking
---
# Event IDs 4016 and 4004 when DNS updates time out

This article helps resolve an issue in which Event IDs 4016 and 4004 are logged in the Domain Name System (DNS) when DNS updates from the Lightweight Directory Access Protocol (LDAP) to Active Directory (AD) time out.

_Original KB number:_ &nbsp; 4559507

In AD-integrated DNS zones that are hosted on domain controllers (Windows Server 2012 R2 or later versions), DNS can't enumerate the zones or intermittently fail to create or write records. Additionally, Event IDs 4016 and 4004 are logged in the DNS event log:

- Event ID 4016
	
	```output
	LogName:       DNS Server
	Source:        Microsoft-Windows-DNS-Server-Service
	Date:          <DateTime>
	Event ID:      4016
	Task Category:
	Level:         Error
	User:          S-1-5-18
	Computer:      Contoso.com
	Description:
	The DNS server timed out attempting an Active Directory service operation on DC=xx.x,DC=xxx.xx.in-addr.arpa,cn=MicrosoftDNS,DC=ForestDnsZones,DC=xxx,DC=com. Check Active Directory to see that it is functioning properly. The event data contains the error.
	```
- Event ID 4004

	```output
	LogName:       DNS Server
	Source:        Microsoft-Windows-DNS-Server-Service
	Date:          <DateTime>
 	Event ID:      4004
	Task Category:
	Level:         Error
	User:          S-1-5-18
	Computer:      Contoso.com
	Description:
	The DNS server was unable to complete directory service enumeration of zone xx.xxx.xx.in-addr.arpa.  This DNS server is configured to use information obtained from Active Directory for this zone and is unable to load the zone without it. Check that the Active Directory is functioning properly and repeat enumeration of the zone. The extended error debug information (which may be empty) is "". The event data contains the error.
	```
	
If Event IDs 4016 and 4004 are logged, the DNS records are updated on other domain controllers and visible in ADSI Edit (*adsiedit.msc*). However, the records can't be written and the DNS updates stop until the DNS Server service is restarted. During this period, records can be created at the same time by using ADSI Edit on the problematic domain controllers. These records are then replicated to all domain controllers, which means the AD is working properly. The memory usage of the *dns.exe* process is low. Meanwhile, the CPU and memory usage on domain controllers is also low, but they remain unresponsive.

By checking the DNS audit logs, event logs and packet captures, DNS updates stop on the server even though DNS queries are responded to quickly. In addition, error 0x55 is logged.

## Restart DNS Server service and delete Kerberos ticket cache

To work around this issue, restart the DNS Server service after deleting the Kerberos ticket cache by using a Windows PowerShell script. See the following script for an example:

> [!NOTE]
> Because the default `$EventIntervalMinutes` and `$NumberOfEvents` values may not be optimal, adjust the values accordingly.

```powershell
    #NOTE: 
# The following two parameters should be adjusted according to your environment.
# The current values are only defaults and may not be optimal for you.

# How long to wait to ensure the 4016 event occurs consistently (that is, not one-offs)
[int]$EventIntervalMinutes=3

# Number of events within $EventIntervalMinutes to indicate we're in an error state
[int]$NumberOfEvents=10

# Monitor forever
while ($True)
{
	# Detect $NumberOfEvents for 4016 or 4011 occurred in the past $EventIntervalMinutes.
	$EntryType = @("Error","Warning")
	$Events = Get-EventLog -LogName 'DNS Server' -After ((get-date).AddMinutes(-$($EventIntervalMinutes))) -EntryType $EntryType

	[int]$NumEvents=0
	[int]$ErrorStateFound=0
	foreach($Event in $Events)
	{
		 if(($Event.InstanceId -eq "4016") -or ($Event.InstanceId -eq "4011"))
		 {
		   $NumEvents += 1;
		 }
	}

	if($NumEvents -ge $NumberOfEvents)
	{
		$ErrorStateFound=1
		"Detected DNS Event ID 4016 and/or 4011 within the past '$($EventIntervalMinutes)' minutes.  Take mitigation actions."  *>> C:\temp\dnsResetLog.txt

		# Stop DNS
		"`n`nStop DNS at $(Get-Date)" *>> C:\temp\dnsResetLog.txt
		Stop-Service DNS -Force *>> C:\temp\dnsResetLog.txt

		do { Start-Sleep 1 } until ((Get-Service DNS).Status -ne "Running")

		# Purge tickets 
		"`nPurge system tickets at $(Get-Date)" *>> C:\temp\dnsResetLog.txt
		klist purge -li 0x3e7 *>> C:\temp\dnsResetLog.txt

		# Start DNS
		"`nStart DNS at $(Get-Date)" *>> C:\temp\dnsResetLog.txt
		Start-Service DNS *>> C:\temp\dnsResetLog.txt

		# Record DNS Server process details to a file
		Get-Process dns | Select-Object Name, Id, StartTime | Format-List | Out-String *>> C:\temp\dnsResetLog.txt

		"`nEnd at $(Get-Date)" *>> C:\temp\dnsResetLog.txt
	}

	if ($ErrorStateFound)
	{
		# Don't loop again until waiting long enough to ensure no new events after restarting the service
		# Otherwise, we'll keep restarting!
		"`n`Sleeping for ($EventIntervalMinutes+1) minutes" *>> C:\temp\dnsResetLog.txt
		Start-Sleep -seconds (60*($EventIntervalMinutes+1))
		"`n`n Starting new monitoring cycle at $(Get-Date)" *>> C:\temp\dnsResetLog.txt
	}
	else{
		# Give a 1-minute pause before checking again
		Start-Sleep -seconds 60
	}
}
```


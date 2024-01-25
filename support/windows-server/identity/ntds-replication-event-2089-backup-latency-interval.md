---
title: NTDS Replication Event 2089 is logged
description: Discusses the problem where a new event error message is logged if you don't back up a Windows Server 2003 Service Pack 1 (SP1)-based domain controller in a given time period that is called the backup latency interval.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-backup-restore-or-disaster-recovery, csstroubleshoot
ms.subservice: active-directory
---
# NTDS Replication Event 2089 is logged if Windows Server 2003 SP1 and later domain controllers aren't backed up in a given time period

This article discusses the problem where a new event error message is logged if you don't back up a Windows Server 2003 Service Pack 1 (SP1)-based domain controller in a given time period that is called the backup latency interval.

_Applies to:_ &nbsp; Window Server 2003  
_Original KB number:_ &nbsp; 914034

## Introduction

When you back up a domain controller that is running Microsoft Windows Server 2003 Service Pack 1 (SP1), a new event error message is logged for each writable domain or application partition that the domain controller hosts. This is true if the partition isn't backed up in a given time period. The time period is called a backup latency interval. You can set a registry value to specify this interval in days.

## More information

### New behavior in Windows Server 2003 SP1

The DSA Signature attribute is modified every time that a system state backup is made. The operating system monitors this attribute. An event error message is logged when the backup latency interval criteria are met. Any Windows Server 2003 SP1-based domain controller may log the event because the DSA Signature attribute is a replicated attribute.

> [!NOTE]
> The new event error message is not logged until a backup is made on a Windows Server 2003-based domain controller that is running Windows Server 2003 SP1. Only Windows Server 2003 SP1-based domain controllers log this event error message.

The default time period of the backup latency interval is half of the Tombstone Lifetime (TSL) for logging the event error message on the domain controller. The following list shows the difference in the default TSL values for a forest that is created on Windows Server 2003 and a forest that is created on Windows Server 2003 SP1:  

- Windows Server 2003  

By default, the TSL value in Windows Server 2003 is 60 days. Therefore, the event error message isn't logged until 30 days after the last backup.  

- Windows Server 2003 SP1  

By default, the TSL value in new forest created by Windows Server 2003 SP1 is 180 days. The TSL value is 60 days in all other cases. The event error message in a forest with a 180-day TSL isn't logged until 90 days after the last backup.

> [!NOTE]
> If you just install Windows Server 2003 SP1 on Windows Server 2003-based computers, this doesn't increase the TSL to 180 days. The forest must be created on a server that has Windows Server 2003 SP1 installed at the time that you create it. For more information, click the following article number to view the article in the Microsoft Knowledge Base:  
[216993](https://support.microsoft.com/help/216993) Useful shelf life of a system-state backup of Active Directory  

### Deployment Strategy

The default value for the backup latency interval in a forest that uses the default TSL is insufficient to correctly warn administrators that partitions aren't being backed up with sufficient frequency.

In the registry, administrators can specify a value for the Backup Latency Threshold (days) entry. This provides a simple method to adjust how soon event ID 2089, is logged if a backup isn't made in a certain time period. Therefore, the time period reflects the backup strategies of the administrators. This event error message serves as a warning to administrators that domain controllers aren't being backed up before the TSL expires. This event error message is also a useful tracking event to monitor applications such as Microsoft Operations Manager (MOM).

We recommend that you take system state backups that include each forest, domain, and application partition on at least two computers every day. We also recommend that you configure this event to occur every other day if a backup isn't made. Third-party backup programs may use a method that calls the backup API that updates the attribute. When these programs use this method, it causes the DSA Signature attribute to be updated.

An event ID 2089 error message is logged in the Directory Service event log when a partition isn't backed up during the backup latency interval. Only one event error message is logged each day for each partition that a domain controller hosts. The event error message is similar to the following:

> Event Type: Warning  
Event Source: NTDS Replication  
Event Category: Backup Event ID: 2089  
Description: This directory partition has not been backed up since at least the following number of days.  
>
> Directory partition:  
DC=domainDC=com  
>
> "Backup latency interval" (days):  
30  

It's recommended that you take a backup as often as possible to recover from accidental loss of data. However, if you haven't taken a backup since at least the "backup latency interval" number of days, this message will be logged every day until a backup is taken. You can take a backup of any replica that holds this partition.

By default the "Backup latency interval" is set to half the "Tombstone Lifetime Interval". If you want to change the default "Backup latency interval", you could do so by adding the following registry key.

"Backup latency interval" (days) registry key:

`System\CurrentControlSet\Services\NTDS\Parameters\Backup Latency Threshold (days)`.

> [!NOTE]
> The value of Backup Latency Threshold (days) is a registry entry but not a key as stated in the event error message. The backup latency interval is half the value of the TSL of the forest. When this value is reached, the operating system logs event ID 2089 in the Directory Service event log. This event ID warns administrators to monitor applications and to make sure that domain controllers are backed up before the TSL expires. To set the interval that the operating system waits before an event ID 2089 is logged, use Registry Editor to set the value of the Backup Latency Threshold (days) entry. To do this, follow these steps:  
>
> 1. Start Registry Editor.
> 2. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`  
> 3. Right-click **Parameters**, point to **New**, and then click **DWORD Value**.
> 4. Type Backup Latency Threshold (days), and then press ENTER.
> 5. Right-click **Backup Latency Threshold (days)**, and then click **Modify**.
> 6. In the **Value data** box, type the number of days to use as a threshold, and then click **OK**.

## References

[https://blogs.msdn.com/brettsh/archive/2006/02/09/528708.aspx](https://blogs.msdn.com/brettsh/archive/2006/02/09/528708.aspx)

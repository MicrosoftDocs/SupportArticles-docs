---
title: Active Directory changes don't replicate
description: Provides a solution to an issue where the replication isn't completed when you replicate Active Directory directory service changes to a domain controller.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, rolandw
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# Active Directory changes do not replicate

This article provides a solution to an issue where the replication isn't completed when you replicate Active Directory service changes to a domain controller.  
*Applies to:*   Supported versions of Windows Server

_Original KB number:_ &nbsp; 830746

## Symptoms

When you try to replicate Active Directory service changes to a supported versions of domain controller, the replication is not completed.

In the event log, you may see events that are similar to the following: 

|Event Source|Event ID|Event String|
| -------- | -------- | -------- |
||
|NTDS Replication|1232|Active Directory attempted to perform a remote procedure call (RPC) to the following server. The call timed out and was cancelled.|
|NTDS Replication|1188|A thread in Active Directory is waiting for the completion of a RPC made to the following domain controller. Domain controller: b8b5a0e4-92d5-4a88-a601-61971d7033af._msdcs.Contoso.com Operation: get changes Thread ID: 448 Timeout period (minutes): 5 Active Directory has attempted to cancel the call and recover this thread. User Action If this condition continues, restart the domain controller.|
|NTDS Replication|1173 with error status 1818|Internal event: Active Directory has encountered the following exception and associated parameters. Exception: e0010002 Parameter: 0 Additional Data Error value: 1818 Internal ID: 5000ede|
|NTDS Replication|1085 with error status 1818|Internal event: Active Directory could not synchronize the following directory partition with the domain controller at the following network address. Directory partition: <NC> Network address: <GUID-based DC name> If this error continues, the Knowledge Consistency Checker (KCC) will reconfigure the replication links and bypass the domain controller. User Action Verify that the network address can be resolved with a DNS query. Additional Data Error value: 1818 The remote procedure call was cancelled.|

In this situation, you also see error 1818 in the output of the repadmin /showrepl command and in the output of the repadmin /showreps command:  
  
*DC=Contoso,DC=com*

*<Sitename>\<DCname> via RPC DC*

*DC object GUID: <GUID> Last attempt @ 2009-11-25 10:56:55 failed, result 1818 (0x71a): Can't retrieve message string 1818*

*(0x71a), error 1815. 823 consecutive failure(s). Last success @ (never).*

## Cause

This issue may occur when destination domain controllers that are performing remote procedure call (RPC)-based replication do not receive replication changes from a source domain controller within the time that the RPC Replication Timeout (mins) registry setting specifies (The default value if the registry entry does not exist is 5 Minutes). You might experience this issue most frequently in one of the following situations:

- You promote a new domain controller into the forest by using the Active Directory Installation Wizard (Dcpromo.exe).
- Existing domain controllers replicate from source domain controllers that are connected over slow network links.

The default value for the RPC Replication Timeout (mins) registry setting on Windows 2000-based computers is 45 minutes. The default value for the RPC Replication Timeout (mins) registry setting on Windows Server 2003-based computers is 5 minutes. When you upgrade the operating system from Windows 2000 to Windows Server 2003, the value for the RPC Replication Timeout (mins) registry setting is changed from 45 minutes to 5 minutes. If a destination domain controller that is performing RPC-based replication does not receive the requested replication package within the time that the RPC Replication Timeout (mins) registry setting specifies, the destination domain controller ends the RPC connection with the non-responsive source domain controller and logs a Warning event.

## Resolution

To resolve this issue, increase the bandwidth of your network connection so that the Active Directory changes replicate in the five-minute timeout period. 

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

---
title: Active Directory changes don't replicate
description: Provides a solution to an issue where the replication isn't completed when you replicate Active Directory directory service changes to a domain controller.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, rolandw, sagiv
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# Active Directory changes do not replicate

This article provides a solution to an issue where the replication isn't completed when you replicate Active Directory service changes to a domain controller.

_Original KB number:_ &nbsp; 830746

## Symptoms

When you try to replicate Active Directory service changes to a supported version of domain controller, the replication isn't completed.

In the event log, you may see events that are similar to the following: 

|Event source|Event ID|Event string|
|---|---|---|
|NTDS Replication|1232|Active Directory attempted to perform a remote procedure call (RPC) to the following server. The call timed out and was cancelled.|
|NTDS Replication|1188|A thread in Active Directory is waiting for the completion of an RPC made to the following domain controller.<br/>Domain controller: b8b5a0e4-92d5-4a88-a601-61971d7033af._msdcs.Contoso.com<br/>Operation: get changes<br/>Thread ID: 448<br/>Timeout period (minutes): 5<br/>Active Directory has attempted to cancel the call and recover this thread.<br/>User Action<br/>If this condition continues, restart the domain controller.|
|NTDS Replication|1173 with error status 1818|Internal event: Active Directory has encountered the following exception and associated parameters.<br/>Exception: e0010002<br/>Parameter: 0<br/>Additional Data Error value: 1818<br/>Internal ID: 5000ede|
|NTDS Replication|1085 with error status 1818|Internal event: Active Directory could not synchronize the following directory partition with the domain controller at the following network address.<br/>Directory partition: \<NC\><br/>Network address: \<GUID-based DC name\><br/>If this error continues, the Knowledge Consistency Checker (KCC) will reconfigure the replication links and bypass the domain controller.<br/>User Action<br/>Verify that the network address can be resolved with a DNS query.<br/>Additional Data Error value: 1818 The remote procedure call was cancelled.|

In this situation, you also see error 1818 in the output of the `repadmin /showrepl` command and in the output of the `repadmin /showreps` command:  

```output
DC=Contoso,DC=com

<Sitename>\<DCname> via RPC DC

DC object GUID: <GUID> Last attempt @ <DateTime> failed, result 1818 (0x71a): Can't retrieve message string 1818

(0x71a), error 1815. 823 consecutive failure(s). Last success @ (never).
```

## Cause

This issue may occur when destination domain controllers that are performing remote procedure call (RPC)-based replication don't receive replication changes from a source domain controller within the time that the `RPC Replication Timeout (mins)` registry setting specifies (The default value is five minutes if the registry entry doesn't exist). You might experience this issue most frequently in one of the following situations:

- You promote a new domain controller into the forest by using the Active Directory Domain Services Configuration Wizard from the Server Manager management console or via the `Install-ADDSDomainController` cmdlet.
- Existing domain controllers replicate from source domain controllers that are connected over slow network links.

> [!NOTE]
> 
> - Registry value name: `RPC Replication Timeout (mins)`
> - Registry value location: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`
> - Registry value type: `REG_DWORD`

The default value for the **RPC Replication Timeout (mins)** registry setting on supported operating systems is five minutes. If a destination domain controller that is performing RPC-based replication doesn't receive the requested replication package within the time that the **RPC Replication Timeout (mins)** registry setting specifies, the destination domain controller ends the RPC connection with the nonresponsive source domain controller and logs a warning event.

## Resolution

To resolve this issue, increase the bandwidth of your network connection so that the Active Directory changes replicate in the five-minute timeout period. 

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

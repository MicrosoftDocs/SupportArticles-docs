---
title: Troubleshoot AD Replication error 8240 There is no such object on the server
description: Describes symptoms, cause, and resolution for AD operations that fail with Win32 error 8240 (There is no such object on the server).
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: jaml, tonnyp, kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Troubleshooting AD Replication error 8240: There is no such object on the server

This article describes the symptoms, cause, and resolution for AD operations that fail with Win32 error 8240: "There is no such object on the server."

> [!NOTE]
> **Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com/).

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2680976

## Symptoms

### Symptom 1

Output of the `Repadmin /ShowReps` command:

> SiteName\\DCName via RPC  
objectGuid: \<GUID>  
Last attempt @ \<Time> failed, result 8240:  
There is no such object on the server.  
Last success @ (never).  

### Symptom 2

When you try to force replication in the Active Directory Sites and Services console (dssite.msc) by using the **Replicate now** option, you receive the following error message:

> The following error occurred during the attempt to synchronize naming context \<Naming Context> from Domain Controller \<Source-DC-Name> to Domain Controller \<Destination-DC-Name>:  
There is no such object on the server. This operation will not continue.  

### Symptom 3

When you try to remove Active Directory from a domain controller, you receive the following error message in the Active Directory installation wizard:

> Active Directory could not transfer the remaining data in directory partition \<Naming-Contentxt> to domain controller \<Domain-Controller>."There is no such object on the server."  

### Symptom 4

You receive NTDS General event 1126 in Directory Service on Domain Controller with error 8240:

> Event Type: Error  
Event Source: NTDS General  
Event Category: Global Catalog  
Event ID: 1126  
Date: \<DateTime>  
Time: \<DateTime>  
User: NT AUTHORITY\\ANONYMOUS LOGON  
Computer: ComputerName  
Description:  
Active Directory was unable to establish a connection with the global catalog.
>
> Additional Data  
Error value:  
8240 There is no such object on the server.  
Internal ID:  
3200ba0  

## Cause

Error 8240 (0x2030) means ERROR_DS_NO_SUCH_OBJECT. This indicates that the specific object couldn't be found in directory. This error may be encountered in the following two situations.

### Situation 1: During AD replication

When a change occurs to an object in Active Directory on the source domain controller, the source domain controller propagates this change to other domain controllers by notifying its replication partners to retrieve this change. Destination domain controllers pull the change from the source domain controller when they receive the change the notification. After the change is retrieved, destination domain controllers try to transact the change into the local database.

The destination domain controller has to look up the changed object in the local database so that the change can be applied to that object. If the target object can't be located for some reason, Active Directory reports error 8240.

This error may be observed in the following situations:

- When a change occurred to an object on the source domain controller but this object was cleaned by the garbage-collection process
- When AD replication recovers after it fails for a time that exceeds the tombstone lifetime (TSL), deletion may not be propagated before the tombstone is cleaned
- When the change-originating domain controller has Active Directory removed before the domain controller has an opportunity to propagate the deletion to other domain controllers that host a writable partition for that domain and the change is replicated to global catalog

### Situation 2: Reported 8240 in 1126 Event (NTDS)

The domain controller tries to locate global catalogs for its functionalities, such as universal group membership lookup. If the system can't locate an available domain controller, event 1126 is reported together with error 8240 in the NTDS event log.

## Resolution

### Situation 1: During AD replication

To troubleshoot this issue, follow these steps:

1. Determine the problematic domain controller that has the inconsistent object. This error means that the local domain controller finds that an inconsistent object exists in its incoming partner (for the specific replication connection) but not local AD database.
2. Determine whether you want to remove the objects or leave those objects as they are, as follows:

   - If you want to remove the objects, you can use the Repadmin.exe command together with the RemoveLingeringObjects switch to remove those inconsistent objects from the source domain controller. For more information, go to the following Microsoft TechNet website:

        [Use Repadmin to remove lingering objects](https://technet.microsoft.com/library/cc785298%28v=ws.10%29.aspx)

        > [!NOTE]
        > For a read-only partition, you have to use the `Repadmin /Rehost` command.
   - If you want to keep those objects, you can create the following objects on the destination domain controller:

        Sub-Key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters`  
        Value Name: Strict Replication Consistency  
        Value Type: REG_DWORD  
        Value Data: 0  

        Sub-Key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters`  
        Value Name: Allow Replication With Divergent and Corrupt Partner  
        Value Type: REG_DWORD  
        Value Data: 1  

        Sub-Key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters`  
        Value Name: Correct Missing Object  
        Value Type: REG_DWORD  
        Value Data: 1  

        > [!NOTE]
        > You must be careful in a large environment that contains many domain controllers, because the propagation of those inconsistent objects could cause more and more domain controllers to report 8240 errors until the propagation is complete.
   - Another option is to forcedly remove Active Directory from the domain controller that contains the inconsistent objects. To do this, follow these steps:
        1. Forcedly remove Active Directory: Active Directory Installation Wizard (Dcpromo.exe) /forceremoval.
        2. Clean up metadata for the domain controller by following the steps in the following article in the Microsoft Knowledge Base: [216498](https://support.microsoft.com/help/216498) How to remove data in Active Directory after an unsuccessful domain controller demotion
        3. Repromote the domain controller by using Dcpromo.exe.

### Situation 2: Reported 8240 in 1126 Event (NTDS)

For the error that indicates that GC isn't available, we may generally follow the GC location process to check. To do this, follow these steps:

1. Check whether there's any specified global catalog in the forest. If there's not, configure a GC.

    > [!NOTE]
    >  After you mark a domain controller as GC, it may take time for KCC to calculate a new replication topology, build the global catalog, and GC ready announcement. How long depends on the replication schedule, the time that is used to replicate the required read-only NCs, and the interval of KCC actvity.
2. Check whether you can obtain a domain controller from DNS through the command lTest.exe /DnsGetDC:\<DomainName> /GC /Force. If you can't GC record in DNS, take the following two actions:
   - GC announcement on existing GCs: use ldp.exe connect to GC to check whether the value of **isGlobalCatalogReady** is set to **true**.
   - Check DNS registration: netdiag /fix.

3. Check whether you can connect to the GC over TCP 3268 through ldp.exe.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

## More information

For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[910204](https://support.microsoft.com/help/910204) Troubleshooting problems with promoting a domain controller to a global catalog server

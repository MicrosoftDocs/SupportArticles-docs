---
title: Troubleshoot AD Replication error 8240 There is no such object on the server
description: Describes symptoms, cause, and resolution for AD operations that fail with Win32 error 8240 (There is no such object on the server).
ms.date: 5/24/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: jaml, tonnyp, kaushika, v-tappelgate
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# Troubleshooting AD Replication error 8240: There is no such object on the server

This article describes the symptoms, cause, and resolution for Active Directory Domain Services (AD DS) operations that fail and generate Win32 error 8240: "There is no such object on the server."

> [!NOTE]  
> **Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com/).

_Applies to:_ &nbsp; All supported versions of Windows Server  
_Original KB number:_ &nbsp; 2680976

## Symptoms

Error 8240 (0x2030 or ERROR_DS_NO_SUCH_OBJECT) indicates that the specific object couldn't be found in AD DS. Two situations can generate this error.

This issue can generate different symptoms under different conditions. This section describes the primary symptoms, and how you might encounter them.

### Situation 1: Domain controller generates NTDS Event ID 1126 when looking for a global catalog

You receive NTDS General event ID 1126 in the Directory Service event log on the Domain Controller. The event data lists error 8240:

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

### Situation 2: A domain controller generates Error 8240 during AD DS operations

The following table lists the conditions under which you might see Error 8240.

| Action | Symptom |
| --- | --- |
| You run the `Repadmin /ShowReps` command at a Windows command prompt. | You see output that resembles the following: <br /><br />\<*SiteName*>\\\<*DCName*><br /> objectGuid: <*GUID*><br />  Last attempt @ <*Time*> failed, result 8240:<br /> There is no such object on the server.<br />Last success @ (never). |
| You use the **Replicate now** command in Active Directory Sites and Services (*dssite.msc*) to force a domain controller to replicate across a selected connection. | You see a message that resembles the following: <br /><br />The following error occurred during the attempt to synchronize naming context \<*Naming-Context*> from Domain Controller \<*Source-DCName*> to Domain Controller \<*Destination-DCName*>:  <br/>There is no such object on the server. This operation will not continue. |
| You try to remove Active Directory from a domain controller. | You receive the following error message in the Active Directory installation wizard:<br /><br />Active Directory could not transfer the remaining data in directory partition \<*Naming-Context*> to domain controller \<*DCName*>. "There is no such object on the server." |

> [!NOTE]  
> The preceding table uses the following variables:
>
> - \<*SiteName*>: The site that the domain controller belongs to.
> - \<*DCName*>: The name of the domain controller.
> - \<*GUID*>: GUID of the object that generated the error.
> - \<*Naming-Context*>: The naming context of the object that generated the error.
> - \<*Source-DCName*>: The name of the domain controller that replicated the object to another domain controller.
> - \<*Destination-DCName*>: The name of the domain controller that received the replicated object.

## ## Solution for Situation 1: Domain controller generates NTDS Event ID 1126 when looking for a global catalog

### Cause of Event ID 1126

When performing tasks such as looking up universal group memberships, Windows relies on domain controllers that have the global catalog role (known as global catalog servers, or GCs). If the system can't locate an available GC, it records Event ID 1126 in the NTDS event log. The event includes error code 8240.

For more information about GCs, see [Planning Global Catalog Server Placement](/windows-server/identity/ad-ds/plan/planning-global-catalog-server-placement).

### Solution for Event ID 1126

Follow these steps:

1. Check whether the forest has a GC. For example, at a Windows PowerShell command prompt on a computer in the forest, run the following command:

   ```powershell
   Get-ADDomainController -Discover -Service "GlobalCatalog"
   ```

1. Do one of the following:

   - If the command identified at least one GC, check for a communication problem between the GC and the domain controller that generated the event.
   - If the command didn't find a GC, continue to the next procedure to add a GC to the forest.

You can add a GC by creating a new domain controller and specifying that is a GC. To add the global catalog server role to an existing domain controller, follow these steps:

1. Open Active Directory Sites and Services (available on the **Tools** menu in Server Manager).


   > [!NOTE]  
   > After you mark a domain controller as a GC in Active Directory Sites and Services, it might take time for it to become fully available. KCC has to calculate a new replication topology, build the global catalog, and transmit a GC-ready announcement. The delay depends on the replication schedule, the time that is used to replicate the required read-only NCs, and the interval of KCC activity.
1. Check whether you can obtain a domain controller from DNS through the command `NLTest.exe /DnsGetDC:<DomainName> /GC /Force`.  
If you can't query GC record in DNS, take the following action:

   - GC announcement on existing GCs: use the PoSh command `Get-ADRootDSE -Server <DCName> | fl serverName , isGlobalCatalogReady` or *ldp.exe* to connect the DC and check to check whether the value of **isGlobalCatalogReady** is set to **true**.
1. Check whether you can connect to the GC over TCP 3268 through *ldp.exe*: `ldp.exe<DCName>:3268`.


### Situation 1: During AD replication

When a change occurs to an object in Active Directory on the source domain controller, the source domain controller propagates this change to other domain controllers by notifying its replication partners to retrieve this change. Destination domain controllers pull the change from the source domain controller when they receive the change the notification. After the change is retrieved, destination domain controllers try to transact the change into the local database.

The destination domain controller has to look up the changed object in the local database so that the change can be applied to that object. If the target object can't be located for some reason, Active Directory reports error 8240.

This error may be observed in the following situations:

- When a change occurred to an object on the source domain controller but this object was cleaned by the garbage-collection process
- When AD replication recovers after it fails for a time that exceeds the tombstone lifetime (TSL), deletion may not be propagated before the tombstone is cleaned
- When the change-originating domain controller has Active Directory removed before the domain controller has an opportunity to propagate the deletion to other domain controllers that host a writable partition for that domain and the change is replicated to global catalog



## Resolution

### Situation 1: During AD replication

To troubleshoot this issue, follow these steps:

1. Determine the problematic domain controller that has the inconsistent object. This error means that the local domain controller finds that an inconsistent object exists in its incoming partner (for the specific replication connection) but not local AD database.
1. Determine whether you want to remove the objects or leave those objects as they are, as follows:

   - The preferred method to detect and remove lingering objects is using [Lingering Object Liquidator v2 (LoLv2)](https://www.microsoft.com/en-us/download/details.aspx?id=56051). In some cases where LoLv2 can't be used, you can use *Repadmin.exe* command together with the RemoveLingeringObjects switch to remove those inconsistent objects from the source domain controller. For more information, go to the following websites:  
   [Lingering Object Liquidator (LoL)](https://www.microsoft.com/en-us/download/details.aspx?id=56051)  
   [Introducing Lingering Object Liquidator v2](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/introducing-lingering-object-liquidator-v2/ba-p/400475)
   
     [Description of the Lingering Object Liquidator tool](/troubleshoot/windows-server/active-directory/lingering-object-liquidator-tool)
     
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
      1. Forcedly remove Active Directory: Active Directory Installation Wizard (`Dcpromo.exe /forceremoval`).
      1. Clean up metadata for the domain controller  
            A convenient method to clean up the domain controller's metadata is using the Active Directory Users and Computers snap-in. For more information, see [Step-By-Step: Manually Removing A Domain Controller Server](https://techcommunity.microsoft.com/t5/itops-talk-blog/step-by-step-manually-removing-a-domain-controller-server/ba-p/280564) and [Clean up Active Directory Domain Controller server metadata](/windows-server/identity/ad-ds/deploy/ad-ds-metadata-cleanup)

      1. Re-promote the domain controller by using *Dcpromo.exe*.

### Situation 2: Reported 8240 in 1126 Event (NTDS)


## Collecting data for Microsoft Support

If you need assistance from Microsoft Support, we recommend that you collect the information by following the steps that are mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

## More information

For more information, see [Troubleshoot problems with promoting a domain controller to a global catalog server](promoting-dc-to-global-catalog-server-issues.md).

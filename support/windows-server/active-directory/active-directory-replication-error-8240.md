---
title: Troubleshoot AD Replication error 8240 There is no such object on the server
description: Describes symptoms, cause, and resolution for AD operations that fail with Win32 error 8240 (There is no such object on the server).
ms.date: 06/05/2024
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

The domain controller records NTDS General event ID 1126 in its Directory Service event log. The event data lists error 8240:

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
| You run the `Repadmin /ShowReps` command at a Windows command prompt. | You see output that resembles the following message: <br /><br />\<*SiteName*>\\\<*DCName*><br /> objectGuid: <*GUID*><br />  Last attempt @ <*Time*> failed, result 8240:<br /> There is no such object on the server.<br />Last success @ (never). |
| You use the **Replicate now** command in Active Directory Sites and Services (*dssite.msc*) to force a domain controller to replicate across a selected connection. | You see a message that resembles the following message: <br /><br />The following error occurred during the attempt to synchronize naming context \<*Naming-Context*> from Domain Controller \<*Source-DCName*> to Domain Controller \<*Destination-DCName*>:  <br/>There is no such object on the server. This operation will not continue. |
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

## Cause and solution for situation 1: Domain controller generates NTDS Event ID 1126 when looking for a global catalog

When Windows performs tasks such as looking up universal group memberships, Windows relies on domain controllers that have the global catalog role (known as global catalog servers, or GCs). If the system can't locate an available GC, it records Event ID 1126 in the NTDS event log. The event includes error code 8240.

For more information about GCs, see [Planning Global Catalog Server Placement](/windows-server/identity/ad-ds/plan/planning-global-catalog-server-placement).

### Check for an existing GC

Follow these steps:

1. Check whether the forest has a GC. For example, at a Windows PowerShell command prompt on a computer in the forest, run the following command:

   ```powershell
   Get-ADDomainController -Discover -Service "GlobalCatalog"
   ```

1. Perform one of the following actions:

   - If the command identified at least one GC, check for a communication problem between the GC and the domain controller that generated the event.
   - If the command didn't find a GC, continue to the next procedure to add a GC to the forest. Otherwise, go to [Check GC connectivity and availability](#check-gc-connectivity-and-availability).

### Add a GC to the forest

You can add a GC by creating a new domain controller and specifying that is a GC. To add the global catalog server role to an existing domain controller, follow these steps:

1. Open Active Directory Sites and Services (*dssite.msc*, also available on the **Tools** menu in Server Manager).
1. Expand **Sites**, expand the site, and then select the domain controller that you want to modify.
1. In the right-hand pane, right-click **NTDS Site Settings**, and then select **Properties**.
1. On the **General** tab, select **Global Catalog**, and then select **OK**.

   > [!NOTE]  
   > After you mark a domain controller as a GC in Active Directory Sites and Services, it might take time for the new GC to become fully available. The Knowledge Consistency Checker (KCC) has to calculate a new replication topology, build the global catalog, and transmit a `GC-ready` announcement. The delay depends on the replication schedule, the time that is used to replicate the required read-only naming contexts, and the interval of KCC activity.

### Check GC connectivity and availability

1. Check whether you can obtain a domain controller from DNS. On a computer in the domain, open a Command Prompt window, and then run the following command:

   ```console
   NLTest.exe /DnsGetDC:<DomainName> /GC /Force
   ```

   > [!NOTE]  
   > In this command, \<*DomainName*> represents the name of the domain of the new GC.

   If you can't query GC record in DNS, check the value of the **isGlobalCatalogReady** attribute. To do this, do one of the following:

      - Open a PowerShell Command Prompt window, and then run the following command:

        ```powershell
        Get-ADRootDSE -Server <GC_Name> | fl serverName , isGlobalCatalogReady
        ```

        > [!NOTE]  
        > In this command, \<*GC_Name*> represents the name of the GC.

      - Open a Command Prompt window, and then run the following command:

        ```console
        ldp.exe <GC_Name>:389
        ```

      In either case, the value of **isGlobalCatalogReady** should be **TRUE**. If the value is **FALSE**, either the replication cycle isn't finished yet or there's another problem in the server.

1. Check whether you can connect to the GC by using port 3268. At the command prompt, run the following command:

   ```console
   ldp.exe <GC_Name>:3268
   ```

   > [!NOTE]  
   >
   >- In this command, \<*GC_Name*> represents the name of the GC.
   >- If you used ldp.exe in step 1, close it and then start it again by using the new port.

## Cause and solution for situation 2: A domain controller generates Error 8240 during AD DS operations

In an AD DS forest, each domain controller maintains information about the forest objects. Any change to an object starts on a single (source) domain controller. From there, the change replicates to the source domain controller's replication partners (destination domain controllers). Those domain controllers replicate the changes further, and eventually all of the domain controllers "know" about the updated object. The following details of the replication process between two domain controllers pertain to error 8240:

1. The source domain controller notifies the destination domain controllers of the change.
1. After they receive the notification, destination domain controllers pull the change from the source domain controller.
1. Each destination domain controller looks up its local copy of the object to apply the change.
1. If the destination domain controller can't find its local copy of the object, it generates error 8240.

The object could be missing for reasons such as the following:

- The object on the source domain controller is a [lingering object](information-lingering-objects.md). This means that the object was deleted from the forest, but for some reason the source domain controller never received this change. In addition, object's tombstone lifetime (TSL) expired before the source domain controller resumed replicating.
- The source domain controller was demoted before all of the destination domain controllers could pull the change. However, the change is replicated to the GC.

### Identify the affected domain controllers and select solution

The first step to resolving this problem is to understand what data is inconsistent and which domain controllers are affected:

In the replication transaction, the domain controller that generated error 8240 is the destination domain controller. The inconsistent object doesn't exist on this domain controller, but does exist on the source domain controller. In some contexts, the text of error 8240 identifies the source domain controller, but in others it doesn't. In a complex replication topology, you might have to use Active Directory Sites and Services and the destination controller's event log to confirm the identity of the source domain controller. Additionally, use those tools to identify other replication partners of the source domain controller that might report the same problem.

Next, determine whether you want to remove the objects, leave those objects as they are, or reset the affected domain controller. The following sections provide more information for each of these options:  

- [Remove inconsistent objects from the source domain controller](#remove).
- [Keep inconsistent objects and integrate them into the forest](#keep).
- [Remove and recreate the inconsistent domain controller](#reset).

### <a name="remove"></a>Option 1: Remove inconsistent objects from the source domain controller

To remove the inconsistent objects, you can treat them as lingering objects. We recommend that you use [Lingering Object Liquidator v2 (LoLv2)](https://www.microsoft.com/download/details.aspx?id=56051) to remove lingering objects. For more information about LoLv2, see:

- [Lingering Object Liquidator (LoL)](https://www.microsoft.com/download/details.aspx?id=56051)
- [Introducing Lingering Object Liquidator v2](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/introducing-lingering-object-liquidator-v2/ba-p/400475)
- [Description of the Lingering Object Liquidator tool](lingering-object-liquidator-tool.md)

In some cases, you can't use LoLv2. Instead, you can use *Repadmin.exe*. You can do this by running the `repadmin /removelingeringobjects` command in advisory mode, as described in [Active Directory replication Event ID 2042: It has been too long since this machine replicated: Identify lingering objects](active-directory-replication-event-id-2042.md#identify-lingering-objects).  

For more information about lingering objects, see [How to detect and remove lingering objects in a Windows Server Active Directory forest](information-lingering-objects.md).

### <a name="keep"></a>Option 2: Keep inconsistent objects and integrate them into the forest

[!INCLUDE [Registry alert](../../includes/registry-important-alert.md)]

If you want to keep the inconsistent objects and replicate them to the rest of the forest, configure the following registry keys on the destination domain controller:

- Subkey: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters`  
  Name: `Strict Replication Consistency`  
  Type: REG_DWORD  
  Data: **0**  

- Subkey: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters`  
  Name: `Allow Replication With Divergent and Corrupt Partner`  
  Type: REG_DWORD  
  Data: **1**  

  Subkey: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters`  
  Name: `Correct Missing Object`  
  Type: REG_DWORD  
  Data: **1**  

After you update these registry entries, allow time for the changes to replicate to the source domain controller. Alternatively, you can use the **Replicate now** command in Active Directory Sites and Services to force the source domain controller to use a specific connection to replicate changes to the destination domain controller.

> [!IMPORTANT]  
> Be careful in a large environment that contains many domain controllers. As the inconsistent objects replicate through the forest, they could cause more domain controllers to report 8240 errors until the replication finishes.

### <a name="reset"></a>Option 3: Remove and recreate the inconsistent domain controller

Another option is to forcibly remove the forest from the source domain controller by demoting it to a member server. Afterwards, clean up the server's metadata in the forest and then re-promote the server. This action re-installs AD DS, and then a fresh copy of the forest data replicates to the new domain controller.

> [!NOTE]  
> The following procedure uses Windows PowerShell commands to demote the domain controller. You can also use Server Manager to demote a domain controller. For more information about the Server Manager method, see [Demoting Domain Controllers and Domains](/windows-server/identity/ad-ds/deploy/demoting-domain-controllers-and-domains--level-200-).

To remove and recreate the source domain controller, follow these steps:

1. On the source domain controller, open an administrative PowerShell window and then run the following command:

   ```powershell
   Uninstall-ADDSDomainController -Force
   ```

   > [!NOTE]  
   > You can also use the Server Manager Remove Roles and Features wizard to perform this task. In the wizard, make sure that you select **Force the removal of this domain controller**. For more information, see [Demoting Domain Controllers and Domains: Credentials](/windows-server/identity/ad-ds/deploy/demoting-domain-controllers-and-domains--level-200-#credentials).

1. In the forest, clean up the metadata that's related to the demoted domain controller.

   > [!NOTE]  
   > There are several approaches to metadata cleanup. For more information about how to do this, see the following articles:
   >
   >- [Clean up Active Directory Domain Controller server metadata](/windows-server/identity/ad-ds/deploy/ad-ds-metadata-cleanup).
   >- [Step-By-Step: Manually Removing A Domain Controller Server](https://techcommunity.microsoft.com/t5/itops-talk-blog/step-by-step-manually-removing-a-domain-controller-server/ba-p/280564).

1. Promote the server to be a domain controller again. You can use Server Manager or Powershell to promote the server. We recommend that you use the method and options that you used to create the original domain controller.

1. Wait for the installation and promotion process to finish and for the forest data to replicate in. You can use Event Viewer to follow this process.

## Collecting data for Microsoft Support

If you need assistance from Microsoft Support, we recommend that you collect the information by following the steps that are mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

## More information

For more information, see [Troubleshoot problems with promoting a domain controller to a global catalog server](promoting-dc-to-global-catalog-server-issues.md).

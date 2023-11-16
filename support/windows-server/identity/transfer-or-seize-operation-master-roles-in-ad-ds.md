---
title: Transfer or seize Operation Master roles
description: Describes how you can use the Ntdsutil.exe utility to move or to seize Operation Master roles, formerly known as Flexible Single Master Operations (FSMO) roles.
ms.date: 03/23/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, herbertm
ms.custom: sap:active-directory-fsmo, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Transfer or seize Operation Master roles in Active Directory Domain Services

This article describes when and how to transfer or seize Operation Master roles, formerly known as Flexible Single Master Operations (FSMO) roles.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012  
_Original KB number:_ &nbsp; 255504

## More information

Within an Active Directory Domain Services (AD DS) forest, there are specific tasks that must be performed by only one domain controller (DC). The DCs that are assigned to perform these unique operations are known as Operation Master role holders. The following table lists the Operation Master roles, and their placement in Active Directory.

|Role|Scope|Naming context (Active Directory partition)|
|---|---|---|
|Schema master|Forest-wide|CN=Schema,CN=configuration,DC=\<forest root domain>|
|Domain naming master|Forest-wide|CN=configuration,DC=\<forest root domain>|
|PDC emulator|Domain-wide|DC=\<domain>|
|RID master|Domain-wide|DC=\<domain>|
|Infrastructure master|Domain-wide|DC=\<domain>|
  
For more information about the Operation Master role holders and recommendations for placing the roles, see [FSMO placement and optimization on Active Directory domain controllers](fsmo-placement-and-optimization-on-ad-dcs.md).

> [!NOTE]
> Active Directory Application partitions that include DNS application partitions have Operation Master role links. If a DNS application partition defines an owner for the infrastructure master (IM) role, you can't use Ntdsutil, DCPromo, or other tools to remove that application partition. For more information, see [DCPROMO demotion fails if unable to contact the DNS infrastructure master](dcpromo-demotion-fails.md).

When a DC that has been acting as a role holder starts to run (for example, after a failure or a shutdown), it doesn't immediately resume behaving as the role holder. The DC waits until it receives inbound replication for its naming context (for example, the Schema master role owner waits to receive inbound replication of the Schema partition).

The information that the DCs pass as part of Active Directory replication includes the identities of the current Operation Master role holders. When the newly started DC receives the inbound replication information, it verifies whether it's still the role holder. If it is, it resumes typical operations. If the replicated information indicates that another DC is acting as the role holder, the newly started DC relinquishes its role ownership. This behavior reduces the chance that the domain or forest will have duplicate Operation Master role holders.

> [!IMPORTANT]
> AD FS operations fail if they require a role holder and if the newly started role holder is, in fact, the role holder and it doesn't receive inbound replication.  
> The resulting behavior resembles what would happen if the role holder was offline.

## Determine when to transfer or seize roles

Under typical conditions, all five roles must be assigned to "live" DCs in the forest. When you create an Active Directory forest, the Active Directory Installation Wizard (_Dcpromo.exe_) assigns all five Operation Master roles to the first DC that it creates in the forest root domain. When you create a child or tree domain, the creation mechanism assigns the three domain-wide roles to the first DC in the domain.

DCs continue to own Operation Master roles until they're reassigned by using one of the following methods:

- An administrator reassigns the role by using a GUI administrative tool.
- An administrator reassigns the role by using the `ntdsutil /roles` command.
- An administrator gracefully demotes a role-holding DC by using the Active Directory Installation Wizard. This wizard reassigns any locally held roles to an existing DC in the forest.
- An administrator demotes a role-holding DC by using the `Uninstall-ADDSDomainController -ForceRemoval` or `dcpromo /forceremoval` command.
- The DC shuts down and restarts. When the DC restarts, it receives inbound replication information that indicates that another DC is the role holder. In this case, the newly started DC relinquishes the role (as described previously).

If an Operation Master role holder experiences a failure or is otherwise taken out of service before its roles are transferred, you must seize and transfer all roles to an appropriate and healthy DC.

We recommend that you transfer Operation Master roles in the following scenarios:

- The current role holder is operational and can be accessed on the network by the new Operation Master owner.
- You're gracefully demoting a DC that currently owns Operation Master roles that you want to assign to a specific DC in your Active Directory forest.
- The DC that currently owns Operation Master roles is being taken offline for scheduled maintenance, and you have to assign specific Operation Master roles to live DCs. You may have to transfer roles to perform operations that affect the Operation Master owner. This is especially true for the PDC Emulator role. This is a less important issue for the RID master role, the Domain naming master role, and the Schema master roles.

We recommend that you seize Operation Master roles in the following scenarios:

- The current role holder is experiencing an operational error that prevents an Operation Master-dependent operation from completing successfully, and you can't transfer the role.
- You use the `Uninstall-ADDSDomainController -ForceRemoval` or `dcpromo /forceremoval` command to force-demote a DC that owns an Operation Master role.

  > [!IMPORTANT]
  > The `force-demote` command can leave Operation Master roles in an invalid state until they're reassigned by an administrator.

- The operating system on the computer that originally owned a specific role no longer exists or has been reinstalled.

> [!NOTE]
>
> - We recommend that you only seize all roles when the previous role holder isn't returning to the domain.
> - If Operation Master roles have to be seized in forest recovery scenarios, see step 5 in [Perform initial recovery](/windows-server/identity/ad-ds/manage/ad-forest-recovery-perform-initial-recovery) under the [Restore the first writeable domain controller in each domain](/windows-server/identity/ad-ds/manage/ad-forest-recovery-perform-initial-recovery#restore-the-first-writeable-domain-controller-in-each-domain) section.
> - After a role transfer or seizure, the new role holder doesn't act immediately. Instead, the new role holder behaves like a restarted role holder and waits for its copy of the naming context for the role (such as the domain partition) to complete a successful inbound replication cycle. This replication requirement helps make sure that the new role holder is as up to date as possible before it takes action. It also limits the window of opportunity for errors. This window includes only changes that the previous role holder did not finish replicating to the other DCs before it went offline. For a list of the naming context for each Operation Master role, see the table at the [More information](#more-information) section.

## Identify a new role holder

The best candidate for the new role holder is a DC that meets the following criteria:

- It resides in the same domain as the previous role holder.
- It has the most recent replicated writable copy of the role partition.

For example, assume that you have to transfer the Schema master role. The Schema master role is part of the schema partition of the forest (CN=Schema,CN=Configuration,DC=\<forest root domain>). The best candidate for a new role holder is a DC that also resides in the forest root domain, and in the same Active Directory site as the current role holder.

> [!CAUTION]
> The infrastructure master role isn't needed anymore if the following conditions are true:
>
> - All domain controllers in the domain are Global Catalogs (GCs). In this case, the GCs get updates that remove cross-domain references.
> - The AD Recycle Bin is enabled in the forest. In this case, each DC is responsible for updating its references.
>
> We recommend you still define a proper owner of the infrastructure master to avoid errors and warnings from monitoring tools.
>
> If you still need the infrastructure master role:  
> Don't put the infrastructure master role on the same DC as the global catalog server. If the infrastructure master runs on a global catalog server, it stops updating object information because it does not contain any references to objects that it doesn't hold. This is because a global catalog server holds a partial replica of every object in the forest.
>
> The infrastructure master role isn't used anymore once you enable Active Directory Recycle Bin. AD Recycle Bin changes the approach to handling object referrals that are being removed.
>
> To test whether a DC is also a global catalog server, follow these steps:
>  
> Using **Active Directory Sites and Services**:
>
> 1. Select **Start** > **Programs** > **Administrative Tools** > **Active Directory Sites and Services**.
> 2. In the navigation pane, double-click **Sites** and then locate the appropriate site or select **Default-first-site-name** if no other sites are available.
> 3. Open the **Servers** folder, and then select the DC.
> 4. In the DC's folder, double-click **NTDS Settings**.
> 5. On the **Action** menu, select **Properties**.
> 6. On the **General** tab, view the **Global Catalog** check box to see whether it's selected.
>
> Using **Windows PowerShell**:
>
> 1. Start PowerShell.
> 2. Type the following cmdlet, and adjust `DC_NAME` with your actual DC name:
>
>    ```powershell
>    (Get-ADDomainController -Filter { Name -Eq 'DC_NAME' }).IsGlobalCatalog
>    ```
>
> 3. The output will be `True` or `False`.

For more information, see:

- [AD Forest Recovery - Seizing an operations master role](/windows-server/identity/ad-ds/manage/ad-forest-recovery-seizing-operations-master-role)
- [Planning Operations Master Role Placement](/windows-server/identity/ad-ds/plan/planning-operations-master-role-placement)

## Seize or transfer Operation Master roles

You can use **Windows PowerShell** or Ntdsutil to seize or transfer roles. For information and examples of how to use PowerShell for these tasks, see [Move-ADDirectoryServerOperationMasterRole](/powershell/module/activedirectory/move-addirectoryserveroperationmasterrole).

> [!IMPORTANT]
> To avoid the risk of duplicate SIDs in the domain, Rid Master seizures increment the next available RID in the pool when you seize the RID master role. This behavior can cause your forest to consume available ranges of RID values significantly (also known as RID burn). So seize the Rid Master only when you're sure that the current Rid Master can't be brought back into service.
>
> If you have to seize the RID master role, consider the following details:
>
> - The [Move-ADDirectoryServerOperationMasterRole](/powershell/module/activedirectory/move-addirectoryserveroperationmasterrole) cmdlet increases the next Rid pool by 30,000 from what it finds in Active Directory.
> - When you use the *Ntdsutil.exe* utility with the `roles` category commands, it increases the next Rid pool by 10,000.

To seize or transfer the Operation Master roles by using the Ntdsutil utility, follow these steps:

1. Sign in to a member computer that has the AD RSAT tools installed, or a DC that is located in the forest where Operation Master roles are being transferred.
    > [!NOTE]
    >
    > - We recommend that you log on to the DC to which you are assigning Operation Master roles.
    > - The signed-in user should be a member of the Enterprise Administrators group to transfer Schema master or Domain naming master roles, or a member of the Domain Administrators group of the domain where the PDC emulator, RID master and the infrastructure master roles are being transferred.

2. Select **Start** > **Run**, type _ntdsutil_ in the **Open** box, and then select **OK**.
3. Type _roles_, and then press Enter.
    > [!NOTE]
    > To see a list of available commands at any one of the prompts in the Ntdsutil utility, type _?_, and then press Enter.

4. Type _connections_, and then press Enter.
5. Type *connect to server \<servername>*, and then press Enter.
    > [!NOTE]
    > In this command, \<servername> is the name of the DC that you want to assign the Operation Master role to.

6. At the **server connections** prompt, type _q_, and then press Enter.
7. Do one of the following actions:
   - To transfer the role: Type *transfer \<role>*, and then press Enter.
      > [!NOTE]
      > In this command, \<role> is the role that you want to transfer.

   - To seize the role: Type *seize \<role>*, and then press Enter.
      > [!NOTE]
      > In this command, \<role> is the role that you want to seize.

   For example, to seize the RID master role, type _seize rid master_. Exceptions are for the PDC emulator role, whose syntax is **seize pdc**, and the Domain naming master, whose syntax is **seize naming master**.

   To see a list of roles that you can transfer or seize, type _?_ at the **fsmo maintenance** prompt, and then press Enter, or see the list of roles at the start of this article.

8. At the **fsmo maintenance** prompt, type _q_, and then press Enter to gain access to the **ntdsutil** prompt. Type _q_, and then press Enter to quit the Ntdsutil utility.

## Considerations when repairing or removing previous role holders

If it's possible, and if you're able to transfer the roles instead of seizing them, fix the previous role holder. If you can't fix the previous role holder, or if you seized the roles, remove the previous role holder from the domain.

> [!IMPORTANT]
> If you plan to use the repaired computer as a DC, we recommend that you rebuild the computer into a DC from scratch instead of restoring the DC from a backup. The restoration process rebuilds the DC as a role holder again.

- To return the repaired computer to the forest as a DC:

  1. Do one of the following actions:
     - Format the hard disk of the former role holder, and then reinstall Windows on the computer.
     - Forcibly demote the former role holder to a member server.

  2. On another DC in the forest, use Ntdsutil to remove the metadata for the former role holder. For more information, see [To clean up server metadata by using Ntdsutil](/windows-server/identity/ad-ds/deploy/ad-ds-metadata-cleanup#to-clean-up-server-metadata-by-using-ntdsutil).

  3. After you clean up the metadata, you can repromote the computer to a DC, and transfer a role back to it.

- To remove the computer from the forest after seizing its roles:

  1. Remove the computer from the domain.
  2. On another DC in the forest, use Ntdsutil to remove the metadata for the former role holder. For more information, see [To clean up server metadata by using Ntdsutil](/windows-server/identity/ad-ds/deploy/ad-ds-metadata-cleanup#to-clean-up-server-metadata-by-using-ntdsutil).

## Considerations when reintegrating replication islands

When part of a domain or forest can't communicate with the rest of the domain or forest for an extended time, the isolated sections of domain or forest are known as replication islands. DCs in one island can't replicate with the DCs in other islands. Over multiple replication cycles, the replication islands fall out of sync. If each island has its own Operation Master role holders, you may have problems when you restore communication between the islands.

> [!IMPORTANT]
> In most cases, you can take advantage of the initial replication requirement (as described in this article) to weed out duplicate role holders. A restarted role holder should relinquish the role if it detects a duplicate role-holder.  
> You may encounter circumstances that this behavior does not resolve. In such cases, the information in this section may be helpful.

The following table identifies the Operation Master roles that can cause problems if a forest or domain has multiple role-holders for that role:

|Role|Potential conflicts between multiple role-holders?|
|---|---|
|Schema master|Yes|
|Domain naming master|Yes|
|RID master|Yes|
|PDC emulator|No|
|Infrastructure master|No|
  
This issue doesn't affect the PDC Emulator master or the infrastructure master. These role holders don't persist operational data. Additionally, the Infrastructure master doesn't make changes often. Therefore, if multiple islands have these role holders, you can reintegrate the islands without causing long-term issues.

The Schema master, the Domain naming master, and the RID master can create objects and persist changes in Active Directory. Each island that has one of these role holders could have duplicate and conflicting schema objects, domains, or RID pools by the time that you restore replication. Before you reintegrate islands, determine which role holders to keep. Remove any duplicate Schema masters, Domain Naming masters, and RID masters by following the repair, removal, and cleanup procedures that are mentioned in this article.

## References

For more information, see:

- [Active Directory FSMO roles in Windows](fsmo-roles.md)
- [FSMO placement and optimization on Active Directory domain controllers](https://support.microsoft.com/help/223346)
- [Flexible Single Master Operation Transfer and Seizure Process](https://support.microsoft.com/help/223787)
- [HOW TO: Use Ntdsutil to find and clean up duplicate security identifiers in Windows Server](https://support.microsoft.com/help/816099)
- [Phantoms, tombstones, and the infrastructure master](phantoms-tombstones-infrastructure-master.md)
- [Troubleshoot DNS Event ID 4013: The DNS server was unable to load AD integrated DNS zones](https://support.microsoft.com/help/2001093)
- [DCPROMO demotion fails if unable to contact the DNS infrastructure master](https://support.microsoft.com/help/2694933)
- [FSMO Roles](/openspecs/windows_protocols/ms-adts/2aae4593-66fa-4d89-a921-1625b19af5b7)
- [Perform initial recovery](/windows-server/identity/ad-ds/manage/ad-forest-recovery-perform-initial-recovery)
- [AD Forest Recovery - Seizing an operations master role](/windows-server/identity/ad-ds/manage/ad-forest-recovery-seizing-operations-master-role)
- [To clean up server metadata by using Ntdsutil](/windows-server/identity/ad-ds/deploy/ad-ds-metadata-cleanup#to-clean-up-server-metadata-by-using-ntdsutil)
- [Planning Operations Master Role Placement](/windows-server/identity/ad-ds/plan/planning-operations-master-role-placement)
- [Move-ADDirectoryServerOperationMasterRole](/powershell/module/activedirectory/move-addirectoryserveroperationmasterrole)

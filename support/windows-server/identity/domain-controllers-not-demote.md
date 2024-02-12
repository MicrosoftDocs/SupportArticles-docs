---
title: Domain controllers don't demote
description: Fixes the problem where domain controllers may not demote gracefully when you use the Active Directory Installation Wizard (Dcpromo.exe) to force demotion if a required dependency or operation fails in Windows Server 2003 or in Windows 2000 Server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: arrenc, kaushika
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
---
# Domain controllers do not demote gracefully when you use the Active Directory Installation Wizard to force demotion

This article provides a workaround for an issue where domain controllers don't demote when you use the Active Directory Installation Wizard (Dcpromo.exe) to force demotion.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 332199

## Symptoms

Microsoft Windows 2000 or Microsoft Windows Server 2003 domain controllers may not gracefully demote by using the Active Directory Installation Wizard (Dcpromo.exe).

## Cause

This behavior may occur if a required dependency or operation fails. These include network connectivity, name resolution, authentication, Active Directory directory service replication, or the location of a critical object in Active Directory.

## Resolution

To resolve this behavior, determine what is preventing the graceful demotion of the Windows 2000 or the Windows Server 2003 domain controller, and then try to demote the domain controller by using the Active Directory Installation Wizard again.

> [!NOTE]
> For Windows Server 2008, the Directory Services Restore Mode (DSRM) is unchanged from Windows Server 2003 with one exception. In Windows Server 2008, you can run the `dcpromo/forceremoval` command to forcibly remove AD DS from a domain controller that is started in DSRM, just as you can in the AD DS stopped state. A domain controller must still be started in DSRM to restore system state data from a backup. For more information about how to do this, see [Restartable AD DS Step-by-Step Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732714(v=ws.10)).

## Workaround

If you cannot resolve the behavior, you can use the following workarounds to perform a forced demotion of the domain controller to preserve the installation of the operating system and of any applications on it.

> [!WARNING]
> Before you use either of the following workarounds, make sure that the you can successfully start in Directory Services Restore mode. Otherwise, you will not be able to log on after you forcefully demote the computer. If you do not remember the Directory Services Restore mode password, you can reset the password by using the Setpwd.exe utility that is located in the `Winnt\System32` folder. In Windows Server 2003, the functionality of the Setpwd.exe utility has been integrated into the Set DSRM Password command of the NTDSUTIL tool.

### Windows 2000 domain controllers

1. Install the Q332199 hotfix on a Windows 2000 domain controller that is running Service Pack 2 (SP2) or a later version, or install Windows 2000 Service Pack 4 (SP4). SP2 and later versions support forced demotion. Then, restart your computer.

2. Click **Start**, click **Run**, and then type the command: `dcpromo /forceremoval`.

3. Click **OK**.

4. At the **Welcome to the Active Directory Installation Wizard** page, click **Next**.

5. If the computer that you are removing is a global catalog server, click **OK** in the message window.

    > [!NOTE]
    > Promote additional global catalogs in the forest or in the site if the domain controller that you are demoting is a global catalog server, as needed.

6. At the **Remove Active Directory** page, make sure that the **This server is the last domain controller in the domain** check box is cleared, and then click **Next**.

7. At the **Network Credentials** page, type the name, password, and domain name for a user account with enterprise administrator credentials in the forest, and then click **Next**.

8. In **Administrator Password**, type the password and confirmed password that you want to assign to the Administrator account of the local SAM database, and then click **Next**.

9. On the **Summary** page, click **Next**.

10. Perform a metadata cleanup for the demoted domain controller on a surviving domain controller in the forest.

If you removed a domain from the forest by using the remove selected domain command in Ntdsutil, verify that all the domain controllers and the global catalog servers in the forest have removed all the objects and the references to the domain that you just removed before you promote a new domain into the same forest with the same domain name. Tools such as Replmon.exe or Repadmin.exe from Windows 2000 Support Tools may help you determine whether end-to-end replication has occurred. Windows 2000 SP3 and earlier global catalog servers are noticeably slower to remove objects and naming contexts than Windows Server 2003 is.

### Windows Server 2003 domain controllers

1. By default, Windows Server 2003 domain controllers support forced demotion. Click **Start**, click **Run**, and then type the command: `dcpromo /forceremoval`.

2. Click **OK**.

3. At the **Welcome to the Active Directory Installation Wizard** page, click **Next**.

4. At the **Force the Removal of Active Directory** page, click **Next**.

5. In **Administrator Password**, type the password and confirmed password that you want to assign to the Administrator account of the local SAM database, and then click **Next**.

6. In **Summary**, click **Next**.

7. Perform a metadata cleanup for the demoted domain controller on a surviving domain controller in the forest.

If you removed a domain from the forest by using the remove selected domain command in Ntdsutil, verify that all the domain controllers and the global catalog servers in the forest have removed all the objects and the references to the domain that you just removed before you promote a new domain into the same forest with the same domain name. Windows 2000 Service Pack 3 (SP3) and earlier global catalog servers are noticeably slower to remove objects and naming contexts than Windows Server 2003 is.

If resource access control entries (ACEs) on the computer that you removed Active Directory from were based on domain local groups, these permissions may have to be reconfigured, because these groups will not be available to member or stand-alone servers. If you plan to install Active Directory on the computer to make it a domain controller in the original domain, you do not have to configure access control lists (ACLs) any more. If you prefer to leave the computer as a member or stand-alone server, any permissions that are based on domain local groups must be translated or replaced.

### Windows Server 2003 Service Pack 1 enhancements

Windows Server 2003 SP1 enhances the `dcpromo /forceremoval` process. When `dcpromo /forceremoval` is executed, a check is made to determine whether the domain controller hosts an operations master role, is a Domain Name System (DNS) server, or is a global catalog server. For each of these roles, the administrator receives a popup warning that advises the administrator to take appropriate action.

### If the domain controller can't start in normal mode

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

> [!IMPORTANT]
> Follow these steps only as a last resort if the domain controller cannot start in normal mode.

To remove Active Directory from a domain controller, follow these steps:

1. Restart the computer, and then press F8 to display the **Windows 2000 Advanced Options** menu.

2. Choose **Directory Services Restore Mode**, press ENTER, and then press ENTER again to continue restarting.

3. Modify the ProductType entry in the registry. To do this, follow these steps:
    1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
    2. Locate the registry subkey `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ProductOptions`.
    3. In the right-pane, double-click **ProductType**.
    4. Type ServerNT in the **Value data** box, and then click **OK**.

        > [!NOTE]
        > If this value is not set correctly or is misspelled, you may receive the following error message:System Process - License Violation: The system has detected tampering with your registered product type. This is a violation of your software license. Tampering with product type is not permitted.

    5. Quit Registry Editor.

4. Restart the computer.

5. Log on with the administrator account and password that is used for Directory Service Repair mode.

    The computer will behave as a member server. However, there are still some remaining files and registry entries on the computer that are associated with the domain controller.

6. Start Registry Editor and locate the registry entry `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`.

    If there is an entry for **Src Root Domain Srv**, right-click the value and then click **Delete**. This value must be deleted so that the domain controller sees itself as the only domain controller in the domain after promotion.

    > [!IMPORTANT]
    > The above step is critical. Without it the re-promotion into the temporary AD forest will not complete and you will not be able to log on to the domain controller.

7. Remove the remaining files and registry entries. To do this, follow these steps:

    1. Start the Active Directory Installation Wizard.
    2. Install Active Directory to make the computer a domain controller for a new, temporary domain, such as *psstemp.deleteme*.

        > [!NOTE]
        > Make sure that you make the computer a domain controller in a different forest.
    3. After you install Active Directory, start the Active Directory Installation Wizard again, and then remove Active Directory from the domain controller.

8. After you remove Active Directory from a domain controller, remove metadata that is left in the domain. For more information about how to remove this metadata, see [How to remove data in Active Directory after an unsuccessful domain controller demotion](/windows-server/identity/ad-ds/deploy/ad-ds-metadata-cleanup).

## Status

Microsoft has tested and supports the forced demotion of domain controllers that are running Windows 2000 or Windows Server 2003.

## More information

The Active Directory Installation Wizard creates Active Directory domain controllers on Windows 2000-based and Windows Server 2003-based computers. Operations that are performed by the Active Directory Installation Wizard include the installation of new services, changes to the startup values of existing services, and the transition to Active Directory as a security and authentication realm.

With forced demotion, a domain administrator can forcibly remove Active Directory and roll back locally held system changes without having to contact or replicate any locally held changes to another domain controller in the forest.

Because forced demotion causes the loss of any locally held changes, use it only as a last resort in production or test domains. You can forcibly demote domain controllers when connectivity, name resolution, authentication, or replication engine dependencies cannot be resolved so that graceful demotion can be performed. Valid scenarios for forced demotions include the following:

- There are no domain controllers currently available in the parent domain when you try to demote the last domain controller in an immediate child domain.

- The Active Directory Installation Wizard cannot complete because there is a name resolution, authentication, replication engine, or Active Directory object dependency that you cannot resolve after you perform detailed troubleshooting.

- A domain controller has not replicated incoming Active Directory changes in Tombstone Lifetime (Default Tombstone Lifetime is 60 days) number of days for one or more naming contexts.

    > [!IMPORTANT]
    > Do not recover such domain controllers unless they are the only chance of recovery for a particular domain.

- Time does not permit more detailed troubleshooting because you must immediately bring into service the domain controller. Forced demotions may be useful in lab and classroom environments where you can remove domain controllers out of existing domains, yet you do not have to demote each domain controller serially.

If you force the demotion of a domain controller, you will lose any unique changes that reside in the Active Directory of the domain controller that you are forcibly demoting. This includes the addition, deletion, or modification of users, computers, groups, trust relationships, and Group Policy or Active Directory configuration that did not replicate off before you ran the `dcpromo /forceremoval` command. Additionally, you will lose changes to any one of the attributes on these objects, such as passwords for users, computers, and trust relationships and group membership.

However, if you force the demotion of a domain controller, you return the operating system to a state that is the same as the successful demotion of the last domain controller in a domain (service start values, installed services, use of a registry based SAM for the account database, computer is a member of a workgroup). Programs that are installed on the demoted domain controller remain installed.

The System event log identifies forcibly demoted Windows 2000 domain controllers and instances of the `dcpromo /forceremoval` operation by event ID 29234. For example: The System event log identifies forcibly demoted Windows Server 2003 domain controllers by event ID 29239. For example: After you use the `dcpromo /forceremoval` command, metadata for the demoted computer is not deleted on surviving domain controllers. For more information, see [Clean up Active Directory Domain Controller server metadata](/windows-server/identity/ad-ds/deploy/ad-ds-metadata-cleanup).

The following are items that you must address, if applicable, after forcibly demoting a domain controller:

1. Remove the computer account from the domain.
2. Verify that DNS records, such as A, CNAME, and SRV Records, are removed, and remove them if they are present.
3. Verify that FRS member objects (FRS and DFS) are removed, and remove them if they are present.
4. If the demoted computer is a member of any security groups, remove it from those groups.
5. Remove any DFS references to the demoted server, such as links or root replicas.
6. A surviving domain controller must seize any operations master roles, also known as flexible single master operations or FSMO, that were previously held by the forcibly demoted domain controller. For more information, see [Transfer or seize Operation Master roles in Active Directory Domain Services](transfer-or-seize-operation-master-roles-in-ad-ds.md).
7. If the domain controller that you are demoting is a DNS server or global catalog server, you must create a new GC or DNS server to satisfy load balancing, fault tolerance, and configuration settings in the forest.
8. When you use the remove selected server command in NTDSUTIL, the NTDSDSA object, the parent object for incoming connections to the domain controller that you forcibly demoted is removed. The command does not remove the parent server objects that appear in the Sites and Services snap-in. Use the Active Directory Sites and Services MMC snap-in to remove the server object if the domain controller will not be promoted into the forest with the same computer name.

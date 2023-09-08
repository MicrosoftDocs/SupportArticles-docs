---
title: Relocate a SYSVOL tree
description: Describes two options for moving the SYSVOL tree on your domain controller. You can use the Active Directory Installation Wizard, or you can edit the registry and manually move the SYSVOL tree.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-backup-restore-or-disaster-recovery, csstroubleshoot
ms.technology: windows-server-active-directory
---
# How to relocate a SYSVOL tree that uses FRS for replication

This article describes two options for relocating the system volume (SYSVOL) tree on your domain controller.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 842162

## Summary

The SYSVOL is a collection of folders, file system reparse points, and Group Policy settings that are replicated by the File Replication Service (FRS). Replication distributes a consistent copy of Group Policy settings and scripts among domain controllers in a domain. Member computers and domain controllers access the contents of the SYSVOL tree through two shared folders, Sysvol and Netlogon.

This article describes how to move the SYSVOL tree and its shares to a different logical or physical drive letter.

This section discusses how to move the SYSVOL tree from the C:\Winnt\Sysvol folder to the X:\Winnt\Sysvol folder. In this example, the domain controller is named DC1, and the domain name is `CONTOSO.COM`.

## Use the Active Directory Installation Wizard to demote and to repromote the domain controller

1. Confirm that inbound and outbound replication is occurring for the Active Directory directory service and for the SYSVOL tree.

2. Use the Active Directory Installation Wizard to do a network-based demotion of the DC1 domain controller. Restart DC1 immediately after the demotion.

3. Before you repromote DC1, wait for the following events to occur:
   - All domain controllers in the forest must inbound replicate the removal of the demoted domain controller's NTDS file system settings object. This object is located in the configuration partition. The NTDS settings object is the parent of Active Directory connection objects that are visible in the Active Directory Sites and Services snap-in.
   
   - All global catalog domain controllers in the forest must inbound replicate the read-only copy of DC1's domain partition.

4. Use the Active Directory Installation Wizard to specify a new drive and path on an NTFS-formatted partition. Demotion and repromotion of a domain controller is a simple and supported option for relocating the SYSVOL tree and its shares if the following conditions are true:

    - A small-to-medium number of objects exist in Active Directory.
    - Local area network (LAN)-speed connectivity is available.
    - Additional domain controllers are available in the affected Active Directory domain and Active Directory site.

However, network-based Active Directory Installation Wizard promotions in domains with multi-gigabyte Active Directory databases may take 2-7 days if network connectivity is slow.

To avoid delays when you promote replica domain controllers that are running Windows Server 2003 or later, you can do installations from media-based promotions, where the bulk of Active Directory is sourced from a locally restored system state backup.

To estimate the required time for a network-based promotion, compare the start and end times for a previous promotion that was comparable in scope. These times are available in the %Systemroot%\Debug\Dcpromo.log file.

## Manually relocate an existing SYSVOL tree to a new location

In the life cycle of a domain controller that is using the File Replication Service (FRS), you may have to relocate the SYSVOL tree to a different logical or physical drive. You may relocate the SYSVOL tree to enhance system performance or to obtain more free disk space for the SYSVOL tree or for the FRS staging folder.

For more information about changing the FRS staging folder to a location that is independent of the SYSVOL tree, see [How to reset the File Replication service staging folder to a different logical drive](../networking/move-frs-staging-folder-to-different-drive.md).

To move a SYSVOL tree to a new drive, use one of the following options:

- Do a network-based Active Directory Installation Wizard (Dcpromo.exe) demotion. Specify a new drive and path for the SYSVOL tree during promotion.

- Modify the registry and manually move the SYSVOL tree to a new drive.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To manually move the SYSVOL tree, move the SYSVOL tree from its drive and path to a new destination drive and path by modifying several registry keys and by resetting reparse points in the file system. To do this task, follow these steps:

1. Prepare your domain controller. To do this task, follow these steps:
    1. Confirm that inbound and outbound Active Directory replication is occurring on the domain controller.

    2. Confirm that inbound and outbound FRS replication of the SYSVOL replica set is occurring on the domain controller.

    3. Turn off antivirus programs or other services that create locks on files or on folders that reside in the SYSVOL tree.

    4. Back up the system state of the domain controller. Back up the file system part of the SYSVOL tree on the domain controller so that you can return the computer to its current configuration if you experience problems with the relocation process.

    5. Stop the FRS.

2. Use Windows Explorer or an equivalent program to copy the original SYSVOL domain tree to the Clipboard.

    For example, if the SYSVOL domain tree is located in the C:\Winnt\Sysvol folder, click to select this folder, click **Edit** on the menu bar, and then click **Copy**.

3. Use Windows Explorer or an equivalent program to paste the contents of the Clipboard in the new path.

    For example, to move the SYSVOL tree to the `X:\Winnt\Sysvol` folder, click to select this folder, click **Edit**, and then click **Paste**.

    The parent folder for the moved SYSVOL tree may be modified. However, we recommend that you maintain the same relative path for the moved SYSVOL tree. For example, if the SYSVOL tree was originally located in the `C:\Winnt\Sysvol` folder and you want to moved the SYSVOL tree on logical drive X, create a `X:\Winn`t folder, and then paste the SYSVOL tree in that folder.

4. Use the Ldp.exe or ADSIedit.msc editors to modify the value of the FRSRootPath attribute in Active Directory. The FRSRootPath attribute must reflect the new replica set root drive and the folder that you specified in step 3. In this example, you would modify the FRSRootPath attribute as follows:

   - DN Path: `cn=Domain System Volume (SYSVOL share),CN=NTFRS Subscriptions,CN=DC1,OU=Domain Controller,DC=CONTOSO.COM`
   - FRSRootPath Value: `X:\Winnt\Sysvol\Domain`

5. Use the Ldp.exe or ADSIedit.msc editors to modify the value for the FRSStagingPath attribute. This attribute must reflect the new staging path, including the new drive and folder that you selected in step 3.

   - DN path: `cn=Domain System Volume (SYSVOL share),CN=NTFRS Subscriptions,CN=DC1,OU=Domain Controller,DC=CONTOSO.COM`
   - FRSStagingPath Value: `X:\Winnt\Sysvol\Staging\Domain`

6. Modify the registry to reflect the new staging drive and folder. To do this task, follow these steps.

    1. Click **Start**, click **Run**, type *regedt32*, and then click **OK**.
    2. Locate and then right-click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`
    3. Right-click the SYSVOL value, and then click Modify. Type a new path for the SYSVOL replica set root. For example, type `X:\Winnt\sysvol\sysvol`.

7. Configure FRS to do a non-authoritative restore of the SYSVOL replica set. To do this task, follow these steps:

    1. Locate and then select the following registry subkey: `\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters\Backup/Restore\Process at Startup`

    2. Right-click the **BurFlags** value, and then select **Modify**. Set the value to **D2** hexadecimal if there are other domain controllers in the same domain. Set the **BurFlags** value to **D4** hexadecimal if only one domain controller exists in the domain.

    > [!IMPORTANT]
    > Do not restart FRS now.

    > [!NOTE]
    > If the domain controller hosts any FRS-replicated DFS roots or links, you may want to set the replica set-specific **BurFlags** registry key to prevent a temporary service outage and re-replication of data in FRS-replicated DFS roots or links.

    For more information, see [Use the BurFlags registry key to reinitialize File Replication Service](../networking/use-burflags-to-reinitialize-frs.md).

8. Apply default permissions to the new path of the SYSVOL tree. To do this task, copy the following text, and then paste it in a Notepad file:

    > [Unicode]  
    Unicode=yes  
    [Version]  
    signature="$CHICAGO$"  
    Revision=1  
    [Profile Description]  
    Description=default perms for sysvol  
    [File Security]  
    ;"%SystemRoot%\SYSVOL",0,"D:AR(A;OICI;FA;;;BA)"  
    ;  ---------------------------------------------------------------------------------------------  
    ;Sysvol. THIS ENVIRONMENT VARIABLE MUST BE   SET!!!!!!!!!!!!!!!!!!!!!!!!!  
    ;  ---------------------------------------------------------------------------------------------  
    "%Sysvol%",2,"D:P(A;CIOI;GRGX;;;AU)(A;CIOI;GRGX;;;SO)(A;CIOI;GA;;;BA)(A;CIOI;GA;;;SY)(A;CIOI;GA;;;CO)"  
    "%Sysvol%\domain\policies",2,"D:P(A;CIOI;GRGX;;;AU)(A;CIOI;GRGX;;;SO)(A;CIOI;GA;;;BA)(A;CIOI;GA;;;SY)(A;CIOI;GA;;;CO)(A;CIOI;GRGWGXSD;;;PA)"

9. Use the following parameters to save the contents of the Notepad file that you created in step 8:

   - File name: `%systemroot%\security\templates\sysvol.inf`
   - Save as type: All Files
   - Encoding: Unicode

    > [!NOTE]
    > The SYSVOL environment variable must be set to point to the new location. Otherwise, the Secedit command does not run successfully.

10. Import the SYSVOL security template. To do this operation, select **Start**, select **Run**, type *cmd*, and then select **OK**. Type the following, and then press ENTER:

    ```console
    secedit /configure /cfg %systemroot%\security\templates\sysvol.inf /db %systemroot%\security\templates\sysvol.db /overwrite
    ```

11. Use the `Linkd` command to update the reparse points in the file system to reflect the new path of the SYSVOL tree. For example, if your domain controller is in the `CONTOSO.COM` domain, and the SYSVOL tree is located in the `X:\Windows\Sysvol` folder, type the following commands at the command prompt on your domain controller. Press ENTER after each command.

    ```console
    linkd X:\Winnt\Sysvol\Sysvol\CONTOSO.COM X:\Winnt\Sysvol\Domain
    linkd X:\Winnt\Sysvol\Staging areas\CONTOSO.COM X:\Winnt\Sysvol\Staging\Domain
    ```

    > [!NOTE]
    > Make sure that the SYSVOL directory tree is created before you run the Linkd command. The command fails if there is data in the CONTOSO.COM directory or subdirectories.

12. Restart FRS.

13. Look for events in the FRS event log that indicate that the replica set is joined and that the SYSVOL folder is changed.

14. On the domain controller, use the `net logon` command or the net view command to verify that the domain controller has shared the Netlogon and Sysvol folders. If the shared folders don't exist, follow these steps:

    1. If the value for the `\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters\Sysvolready` registry subkey is 1, restart the Netlogon service. If this subkey value is 0, go to step c.

    2. Look for the shared folders again. If the folders are still not available, type the `nltest /dbflag:2080FFFF` command at a command prompt, and then press ENTER:

        Look for errors in the `%Systemroot%\Debug\Netlogon.log` file.
    3. If the value for the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters\Sysvolready` registry subkey is 0, don't set the registry value to 1. Review the FRS debug logs in the `%Systemroot%\Debug`folder to verify that inbound and outbound FRS replication is occurring.

15. Restart any services that you stopped in step 1c.

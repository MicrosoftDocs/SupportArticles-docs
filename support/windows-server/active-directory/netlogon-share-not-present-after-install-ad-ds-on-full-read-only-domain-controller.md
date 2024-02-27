---
title: The NETLOGON share is not present after you install Active Directory Domain Services on a new full or read-only Windows Server 2008-based domain controller
description: This article contains a workaround for a problem that occurs after you install AD DS on a new full or read-only Windows Server 2008-based domain controller.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, gregue
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
---
# The NETLOGON share is not present after you install Active Directory Domain Services on a new full or read-only Windows Server 2008-based domain controller

This article provides a workaround for an issue that occurs after you install Active Directory Domain Services on a new full or read-only Windows Server 2008-based domain controller.

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 947022

## Symptoms

After you install Active Directory Domain Services on a new full or read-only Windows Server 2008-based domain controller in an existing domain, the SYSVOL share is present. However, the NETLOGON share is not present on the new domain controller.

> [!NOTE]
> This article does not apply if both NETLOGON and SYSVOL shares are missing.

## Cause

This problem occurs when the Netlogon service reads the SysvolReady Flag in the registry very quickly. Then, the Netlogon service tries to share out the \\Windows\\SYSVOL\\domain\\scripts folder before the NT File Replication Service (NTFRS) creates this folder.

## Workaround

> [!NOTE]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To work around this issue, set the SysvolReady Flag registry value to 0 and then back to 1 in the registry. To do this, follow these steps:

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate the following subkey in Registry Editor:  `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`

3. In the details pane, right-click the **SysvolReady** flag, and then click **Modify**.
4. In the **Value data** box, type *0*, and then click **OK**.
5. Again in the details pane, right-click the **SysvolReady** flag, and then click **Modify**.
6. In the **Value data** box, type *1*, and then click **OK**.

> [!NOTE]
> This will cause Netlogon to share out SYSVOL, and the scripts folder will be present.

## More information

The problem that is described in the [Symptoms](#symptoms) section occurs in the following scenario:

1. NTFRS first puts changes in the following location:  
    \\Windows\\SYSVOL\\domain\\DO_NOT_REMOVE_NtFrs_PreInstall_Directory

    Then, NTFRS notifies Netlogon to share out SYSVOL by setting the SysvolReady Flag registry entry to 1.

2. NTFRS then moves and renames files from the location that is mentioned in step 1 to the following folder:  
    \\Windows\\SYSVOL\\domain

3. However, if the Netlogon service reads the SysvolReady Flag entry in the registry very quickly, the Netlogon service tries to share out the \\Windows\\SYSVOL\\domain\\scripts folder before NTFRS creates this folder. Therefore, the NETLOGON share is not created.

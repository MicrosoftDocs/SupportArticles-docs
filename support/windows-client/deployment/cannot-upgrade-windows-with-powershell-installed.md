---
title: Can't upgrade Windows with PowerShell installed
description: Discusses an error message that directs you to uninstall Windows PowerShell 1.0 before you upgrade a Windows-based operating system. A workaround is provided.
ms.data: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, williamm
ms.prod-support-area-path: Setup
ms.technology: Deployment
---
# You cannot upgrade a Windows-based operating system when you have Windows PowerShell 1.0 installed

This article provides a workaround for an issue where you can't upgrade a Windows-based operating system when you have Windows PowerShell 1.0 installed.

> [!NOTE]
> Support for Windows Vista Service Pack 1 (SP1) ends on July 12, 2011. To continue receiving security updates for Windows, make sure you're running Windows Vista with Service Pack 2 (SP2). For more information, see this Microsoft web page: [Support is ending for some versions of Windows](https://windows.microsoft.com/windows/help/end-support-windows-xp-sp2-windows-vista-without-service-packs).  

_Original product version:_ &nbsp;Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp;950376

## Symptoms

When you try to upgrade the operating system on a computer that has Windows PowerShell 1.0 installed, the upgrade fails. Additionally, the Compatibility Check feature displays the following message: You must make the following changes before upgrading Windows:

Uninstall the following program:

- Windows PowerShell

## Workaround

To work around this problem, eliminate the Compatibility Check error. To do this, follow these steps:

1. Uninstall Windows PowerShell 1.0.
2. Perform the operating system upgrade again.
3. Reinstall Windows PowerShell 1.0.

## More information

### How to uninstall Windows PowerShell 1.0

To uninstall Windows PowerShell 1.0, follow the steps that are appropriate to your operating system.

#### Windows Vista

1. Click **Start**, type **appwiz.cpl** in the **Start Search** box, and then press ENTER.
2. In the list of tasks, click **View Installed Updates**.
3. In the **Uninstall an update** list, right-click **Windows PowerShell(TM) 1.0 (KB928439)**, and then click **Uninstall**.
4. Follow the instructions to uninstall Windows PowerShell 1.0.

    > [!NOTE]
    > If you disable Windows PowerShell by using the **Turn Windows Features on or off** option, this does not satisfy the Compatibility Check process. You must uninstall Windows PowerShell.

#### Windows Server 2003

1. Click **Start**, click **Run**, type **appwiz.cpl**, and then click **OK**.
2. Click to select the **Show updates** check box.
3. In the **Currently installed programs and updates** list, find the entry for the hotfix that installed Windows PowerShell 1.0. Depending on the installation package that was used, this entry resembles one of the following:
   - Hotfix for Windows Server 2003 (KB926139)
   - Hotfix for Windows Server 2003 (KB926140)
   - Hotfix for Windows Server 2003 (KB926141)
4. Click the Windows PowerShell hotfix entry, and then click **Remove**.
5. Follow the instructions to uninstall the hotfix for Windows PowerShell 1.0.

> [!NOTE]
> By default, if Windows Server 2003 Service Pack 2 is installed on the system, PowerShell 1.0 cannot be uninstalled. To resolve this issue, follow these steps:  
>
>1. Follow the steps in the following Microsoft Knowledge Base (KB) article, 931941, to trust Windows PowerShell 1.0 that was introduced in KB926139: [931941](https://support.microsoft.com/help/931941) The Oobmig.exe tool is available to restore trust to out-of-band updates after you install Windows Server 2003 Service Pack 2. Note You may have to restart the computer.
> 2. Check whether the update can be uninstalled by using Control Panel. If the update cannot be uninstalled in this manner, uninstall PowerShell manually from the following location:
C:\WINNT\$NtUninstallKB926139$\spuninst\spuninst.exe. Note You may have to restart the computer.

#### Windows XP

1. Click **Start**, click **Run**, type **appwiz.cpl**, and then click **OK**.
2. Click to select the **Show updates** check box.
3. In the **Currently installed programs and updates** list, click **Windows PowerShell(TM) 1.0**, and then click **Remove**.
4. Follow the instructions to uninstall Windows PowerShell 1.0.  

For more information about the Windows PowerShell 1.0 installation package for Windows Vista, click the following article number to view the article in the Microsoft Knowledge Base:

[928439](https://support.microsoft.com/help/928439) Windows PowerShell 1.0 Installation Package for Windows Vista  

For more information about Windows PowerShell, visit the following Microsoft Web sites:

- [Windows PowerShell blog](https://devblogs.microsoft.com/powershell/)

- [Windows PowerShell SDK](https://docs.microsoft.com/powershell/scripting/developer/windows-powershell?view=powershell-7&preserve-view=true)

---
title: Deactivate the kernel mode filter driver
description: Describes how you can temporarily deactivate the kernel mode filter driver in Windows.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, WalterE
ms.custom: sap:servicing, csstroubleshoot
ms.subservice: deployment
---
# How to temporarily deactivate the kernel mode filter driver in Windows

This article describes how to deactivate the kernel mode filter driver without removing the corresponding software.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 816071

> [!IMPORTANT]
> This article contains information that shows you how to help lower security settings or how to turn off security features on a computer. You can make these changes to work around a specific problem. Before you make these changes, we recommend that you evaluate the risks that are associated with implementing this workaround in your particular environment. If you implement this workaround, take any appropriate additional steps to help protect your system.

## Summary

You may want to deactivate the filter driver when you are troubleshooting the following issues:

- File copy or backup problems.
- Program errors that occur when you are opening files from network drives or you are saving files to network drives. For more information about these program errors, see [Slow network performance when you open a file that is located in a shared folder on a remote network computer](https://support.microsoft.com/help/829700).

- Event ID 2022 errors messages that occur in the System log, for example:

## Disable filter drivers

When you are troubleshooting any one of these issues, frequently, you have to do more than just stop or disable the services that are associated with the software. Even if you disable the software component, the filter driver is still loaded when you restart the computer. You may be forced to remove a software component to find the cause of an issue. As an alternative to removing the software component, you can stop the relevant services and disable the corresponding filter drivers in the registry. For example, if you prevent antivirus software from scanning or filtering files on your computer, you must also disable the corresponding filter drivers.

To disable filter drivers, you must first identify third-party services and their corresponding filter drivers. After you do this, follow these steps.

> [!WARNING]
> This workaround may make your computer or your network more vulnerable to attack by malicious users or by malicious software such as viruses. We do not recommend this workaround but are providing this information so that you can implement this workaround at your own discretion. Use this workaround at your own risk.

> [!IMPORTANT]
> An antivirus program is designed to help protect your computer from viruses. You must not download or open files from sources that you do not trust, visit Web sites that you do not trust, or open e-mail attachments when your antivirus program is disabled.

For more information about computer viruses, see [How to prevent and remove viruses and other malware](https://support.microsoft.com/help/129972).

1. Stop all services that belong to the software package.

2. Set the Startup type to **Disabled**. To do this, follow these steps:

    1. Click **Start**, click **Control Panel**, double-click **Administrative Tools**, and then double-click **Services**.
    2. In the **Details** pane, right-click the service that you want to configure, and then click **Properties**.
    3. On the **General** tab, click **Disabled** in the **Startup type** box.

3. Set the **Start** registry key of the corresponding filter drivers to **0x4**. A value of **0x4** will disable the filter driver. To do this, follow these steps.

    > [!IMPORTANT]
    > This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

    1. Start Registry Editor.
    2. Create a backup of the HKEY_LOCAL_MACHINE\System registry hive.
    3. Locate, and then click the registry subkey `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services`.
    4. Click the entry for the filter driver that you want to disable.
    5. Double-click the **Start** registry setting, and then set it to a value of **0x4**.

    > [!NOTE]
    > This registry entry typically has a value of 0x3.

4. Restart the computer.

Most antivirus software uses filter drivers that work together with a service to scan for viruses. These filter drivers are still loaded after the service is deactivated. These filter drivers scan files as they are opened and closed on a hard disk. For troubleshooting purposes, temporarily remove the antivirus software or contact the manufacturer of the software to determine whether a newer version is available.

## Example of filter drivers

This section describes some of the typical filter driver names by product:

### Antivirus

- Inoculan: INO_FLPY and INO_FLTR
- Norton: SYMEVENT, NAVAP, NAVEN, and NAVEX
- McAfee (NAI): NaiFiltr and NaiFsRec
- Trend Micro: Tmfilter.sys and Vsapint.sys

### Backup agent

- Backup Agent for Open Files: Ofant.sys
- Open Transaction Manager from Veritas BackupExec: Otman.sys (Otman4.sys or Otman5.sys)

    > [!NOTE]
    > Use caution if you disable these filter drivers by using the method that is described in this article. If you do this, you may receive a **stop 0x7b** error message.

    The **stop 0x7b Inaccessible_Boot_Device** error message may occur if the following registry keys exist and contain references to the Otman5 driver when the Otman5.sys driver either does not exist on the hard disk or if the driver is set to disabled.

  - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E967-E325 -11CE-BFC1-08002BE10318}\UpperFilters`

  - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{71A27CDD-812A -11D0-BEC7-08002BE2092F}\UpperFilters`

    If you experience the stop 0x7b error message, you should back up these registry keys and delete the Otman5 reference.

## Driver registry settings

The following table lists valid settings and their description for the driver's **Start** and **Type** registry settings:

|Value Name|Value Setting|Description of Value Setting|
|---|---|---|
|Start|0 = SERVICE_BOOT_START|Ntldr or Osloader preloads the driver so that it is in memory when the computer starts.<br/><br/>These drivers are initialized just before the SERVICE_SYSTEM_START drivers.|
|Start|1 = SERVICE_SYSTEM_START|The driver loads and initializes after SERVICE_BOOT_START drivers have initialized.|
|Start|2 = SERVICE_AUTO_START|Service Control Manager (SCM) starts the driver or service.|
|Start|3 = SERVICE_DEMAND_START|SCM must start the driver or service on demand.|
|Start|4 = SERVICE_DISABLED|The driver or service does not load or initialize.|
|Type|1 = SERVICE_KERNEL_DRIVER|Device driver.|
|Type|2 = SERVICE_FILE_SYSTEM_DRIVER|Kernel-mode file system driver.|
|Type|8 = SERVICE_RECOGNIZER_DRIVER|File system recognizer driver.|
  
[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).

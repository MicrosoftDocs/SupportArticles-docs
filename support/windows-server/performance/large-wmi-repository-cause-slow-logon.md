---
title: Large WMI repository causes slow logon
description: Provides help to solve slow logon process that occurs when users log on to the Remote Desktop servers.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, Ajayps, v-jesits
ms.custom: sap:boot-is-slow, csstroubleshoot
---
# Unexpectedly slow logon caused by large WMI repository in Windows or Windows Server

This article provides help to solve slow logon process that occurs when users log on to the Remote Desktop servers.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2020286

## Symptoms

You notice one of the following symptoms:

- The logon process is unexpectedly slow when users log on to the Remote Desktop servers.
- Users experience delays when they log on to the console of a Windows client or of a Windows Server-based computer.

This delay is logged in the Userenv.log log file in Windows Server 2003 and in the Gpsvc.log log file in Windows 8.1, Windows 8, and Windows 7 clients and on Windows Server 2012 R2-based, Windows Server 2012-based, Windows Server 2008 R2-based, and Windows Server 2008-based computers.

**Example Userenv.log entry:**
  
USERENV(234.82c) 08:28:36:210 ParseRegistryFile: Leaving.  
USERENV(234.82c) 08:30:26:839 LogRegistry RsopData: Successfully logged registry Rsop data

This example shows a ~ 2-minute delay in writing RSoP logging data.

### How to enable logging in the Gpsvc.log file on Windows 8.1, Windows 8, and Windows 7 clients and Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, and Windows Server 2008 computers

To enable logging in the Gpsvc.log file, follow these steps.

> [!Important]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/kb/322756) How to back up and restore the registry in Windows

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the following registry subkey:

    `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion`

3. On the **Edit** menu, point to **New**, and then click **Key**.
4. Type *Diagnostics*, and then press Enter.
5. Right-click the **Diagnostics** entry, point to **New**, and then click **DWORD Value**.
6. Type *GPSvcDebugLevel*, and then press Enter.
7. Right-click **GPSvcDebugLevel**, and then click **Modify**.
8. In the **Value data** box, type *0x30002*, and then click **OK**.
9. Exit **Registry Editor**.
10. At a command prompt, type the following command, and then press Enter:

    ```console
    gpupdate /force 
    ```

11. View the Gpsvc.log file in the following folder: %windir%\\debug\\usermode.

    > [!NOTE]
    > If the Usermode folder does not exist under %WINDIR%\\debug\\, the Gpsvc.log file will not be created. If the Usermode folder does not exist, create it under %windir%\\debug.

**Example Gpsvc.log entry:**
  
GPSVC(638.13d4) hh:mm:41:316 AllocAdmFileInfo: Adding File name <\\\\contoso.com\\sysvol\\contoso.com\\Policies\\{\<policy guid>}\\Adm\\wuau.adm> to the Adm list.  
GPSVC(638.13d4) hh:mm:47:556 LogRegistry RsopData: Successfully logged registry Rsop dataThis example shows a ~ 6-second delay in writing RSoP logging data.

## Cause

This issue may occur if RSoP logging is enabled and there is a large WMI repository on the problem Windows client or Windows Server computer. The WMI repository is located on the following path:

%windir%\\System32\\Wbem\\Repository

RSoP uses the CIMOM database through WMI. When a computer logs on to a network, information such as the computer hardware, Group Policy Software Installation settings, Internet Explorer Maintenance settings, Scripts, Folder Redirection settings, and Security Settings, are written to the CIMOM database. When you start RSoP in logging mode, RSoP reports policy settings that have been applied by using the information that is provided in the CIMOM database.

The RSoP logging process to the WMI repository causes delays to console logons and especially Remote Desktop logons.

Larger WMI repository sizes in %windir%\\system32\\wbem\\repository cause longer logon delays.
For more information about RSoP, see the following Microsoft TechNet topic:

[RSoP Overview](/previous-versions/windows/it-pro/windows-server-2003/cc778752(v=ws.10))

## Workaround

To work around this issue, determine the size of the WMI repository.

The WMI repository is located on the following path:

%windir%\\System32\\Wbem\\Repository

If the size of the WMI repository is large, temporarily disable RSoP logging to monitor its impact on user logons.

To disable RSoP logging, enable the following Group Policy setting:

Turn off RSoP logging (Computer Configuration/Administrative Templates/System/Group Policy)

> [!NOTE]
> This setting allows you to enable or disable Resultant Set of Policy (RSoP) logging on a client computer.

After you enable this policy, run `gpupdate /force` on the computer, and then restart the computer. Measure the impact on user logon duration.

> [!NOTE]
> By disabling RSoP logging, you prevent the RSoP snap-in (rsop.msc) from running on that computer. You can get RSoP modeling information by using the Group Policy Management Console (GPMC), if it is necessary.  

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#wmi).

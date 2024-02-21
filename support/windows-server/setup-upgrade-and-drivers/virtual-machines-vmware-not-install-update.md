---
title: VMware driver installation fails in Windows Server 2008 R2 SP1
description: Resolves an issue in which you can't install drivers in virtual machines that are hosted on VMware. This issue occurs if you don't select the Allow service to interact with desktop checkbox.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: henrche, kaushika
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# VMware driver installation fails in Windows Server 2008 R2 SP1

This article helps resolve an issue in which you can't install drivers in virtual machines that are hosted on VMware. This issue occurs if you don't select the "Allow service to interact with desktop" checkbox.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 3025586

## Symptoms

Virtual machines in VMware don't install or update a driver successfully if the following conditions are true:

- You install the Telnet Server service on a computer that is running Windows Server 2008 R2 Service Pack 1 (SP1) and has VMware vSphere installed.
- You configure the Telnet Server service to start manually or automatically in the Services Microsoft Management Console (MMC). Additionally, you modify the Telnet Server service to log on by using the Local System account, and you don't select the "Allow service to interact with desktop" checkbox.

When you try to install the driver in Device Manager in virtual machines, it fails and you receive the following error message:

> Windows found driver software for your device but encountered an error while attempting to install it.

Moreover, a log that resembles the following is logged in the setupapi.dev.log file that is located in the %windir%/inf folder:

> dvi: {Plug and Play Service: Device Install for PCI\VEN_15AD&DEV_07B0&SUBSYS_07B015AD&REV_01\FF565000B37984FE00}  
ump: Creating Install Process: DrvInst.exe *\<DateTime>*  
ump: Server install process exited with code 0xc0000142 *\<DateTime>*  
ump: {Plug and Play Service: Device Install exit(c0000142)}  
ndv: Device Install failed for new device...installing NULL driver.  
dvi: {Plug and Play Service: Device Install for PCI\VEN_15AD&DEV_07B0&SUBSYS_07B015AD&REV_01\FF565000B37984FE00}  

## Cause

This issue occurs for security reasons. The Telnet Server service makes some permission changes to the window station in which it's running during initialization. If you configure the Telnet Server service to run by using the Local System account without the ability to interact with the desktop, it's started under a different window station. This may cause problems for other processes that also run under the Local System account and don't interact with the desktop. One such process is the driver install process that is used during installation of a new device driver.

## Workaround

To work around this problem, don't change the Telnet Server service to run under the Local System account. We recommended that you leave the Telnet Server service running under its default Local Service account.

If it still doesn't resolve the issue, you can verify that the latest version of VMWare Tools that is installed. If you notice that you can't update VMWare Tools or uninstall it, follow these steps:  

1. Obtain the setup files for the latest version of VMWare Tools.  
2. Click **Start**, click **Run**, type cmd, and then click **OK**. A Command Prompt window opens.  
3. Change the drive to the CD-ROM drive where the VMware Tools setup files are (For example, D:\\).
4. Type setup /c and press Enter to force removal of all registry entries and delete the old version of VMware Tools.

    > [!NOTE]
    > For 64-bit guest operating systems, type setup64 /c .

5. Any earlier versions of VMware Tools should be removed.
6. Install the latest version of VMware Tools and then perform a restart after you verify that the setting for the Telnet Server service logon setting is set correctly.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

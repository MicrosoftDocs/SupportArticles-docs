---
title: You can't install a VMWare driver in Windows Server 2008 R2
description: Discusses that you can't install a VMWare driver on a server that is running Windows Server 2008 R2 and that has the Telnet Server service installed. Provides a workaround.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:devices-and-drivers, csstroubleshoot
ms.subservice: deployment
---
# You can't install a VMWare driver on Windows Server 2008 R2

This article provides a workaround for an issue where you can't install a VMWare driver on a server that is running Windows Server 2008 R2 and that has the Telnet Server service installed.  

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 3066752

## Symptoms

Consider the following scenario:  

- On a computer that is running Windows Server 2008 R2, you add an Ethernet adapter to a VMWare vSphere environment.
- The Telnet Server service is installed.
- In the Services snap-in of the Microsoft Management Console (MMC), you configure the Telnet Server service to start manually or automatically.
- In the Services snap-in, you configure the Telnet Server service to log on by using the Local System account. Additionally, you don't select the **Allow service to interact with desktop** checkbox.

In this scenario, when you try to install the driver through Device Manager, the attempt fails, and you receive the following error message:

> Windows found driver software for your device but encountered an error while attempting to install it.

After the installation failure occurs, you try unsuccessfully to install another available Ethernet adapter from the VM Settings list. For example, you select Intel E1000. However, the second driver also doesn't install. Additionally, a log entry that resembles the following is logged in Setupapi.dev.log under **%windir%/inf/**:

> dvi: {Plug and Play Service: Device Install for PCI\VEN_15AD&DEV_07B0&SUBSYS_07B015AD&REV_01\FF565000B37984FE00}  
ump: Creating Install Process: DrvInst.exe *\<DateTime>*  
ump: Server install process exited with code 0xc0000142 *\<DateTime>*  
ump: {Plug and Play Service: Device Install exit(c0000142)}  
ndv: Device Install failed for new device...installing NULL driver.  
dvi: {Plug and Play Service: Device Install for PCI\VEN_15AD&DEV_07B0&SUBSYS_07B015AD&REV_01\FF565000B37984FE00}  

## Cause

This problem occurs because the Telnet Server service makes some security-related permission changes during initialization to the window station that it's running in. If you configure the Telnet Server service to run by using the Local System account without the ability to interact with the desktop, the service starts under a different window station. This may cause conflicts with other processes that also run under the Local System account and that don't interact with the desktop, such as the installation process for a new device driver.

## Workaround

To work around this problem, don't run the Telnet Server service under the Local System account. We recommend that you leave the Telnet Server service to run under its default Local Service account.

If this doesn't temporarily fix the problem, verify that the latest version of VMWare Tools is installed. If you can't update or uninstall VMWare Tools, follow these steps:  

1. Obtain the setup files for the latest version of VMWare Tools.
2. Click **Start**, type cmd in the **Start Search** box, and then click **OK**.

    > [!NOTE]
    > A Command Prompt window opens.
3. At the command prompt, change the drive to your CD-ROM drive (For example, drive D).
4. Type `setup /c`, and then press Enter to force removal of all registry entries and delete any previous versions of VMware Tools.

    > [!NOTE]
    > For 64-bit guest operating systems, type setup64 /c instead.
5. Install the latest version of VMWare Tools.
6. Verify that the Telnet Service logon setting is set correctly.
7. Restart the server.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

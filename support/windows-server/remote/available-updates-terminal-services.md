---
title: Available updates for Terminal Services
description: Lists the available updates for Terminal Services (Remote Desktop Services) in Windows Server 2008. Arranges the hotfixes and updates by component areas within Terminal Services.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, Davjoh
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
---
# Available updates for Terminal Services (Remote Desktop Services) in Windows Server 2008

This article summarizes the available hotfixes and updates for issues that can occur in Terminal Services for Windows Server 2008 environments.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2312539

## Summary

For Windows Server 2008 R2 Remote Desktop Services updates, see [Available updates for Remote Desktop Services (Terminal Services) on Windows Server 2008 R2 SP1](remote-desktop-services-updates.md).

> [!CAUTION]
> This list is an aggregate of common issues seen with Terminal Services in Windows Server 2008. Don't proactively install the following patches unless instructed by a Microsoft Support Professional. If you believe that you are experiencing one of the issues in this list, install only the hotfix for that specific issue. If a specific hotfix is listed for your issue, we recommend that you evaluate these hotfixes and updates to determine whether they apply to a specific Windows version and service pack level.

These hotfixes and updates are arranged by component areas within Terminal Services in Windows Server 2008 environments. The hotfixes and updates could also apply to Windows XP, to Windows Vista, and to Windows 7 Remote Desktop clients.

## Authentication

[2203302](https://support.microsoft.com/help/2203302) An RDP connection that uses SSL authentication and CredSSP protocol fails in Windows 7, in Windows Server 2008 R2, in Windows Vista, and in Windows Server 2008

## Core

[2523307](https://support.microsoft.com/help/2523307) A shadowed Windows Server 2008 Terminal Services session is disconnected from a computer that is running Windows Server 2008 R2 SP1 or Windows 7 SP1

[2518298](https://support.microsoft.com/help/2518298)"0x0000003B" Stop error on a terminal server in Windows Server 2008

[2481109](https://support.microsoft.com/help/2481109) MS11-017: Description of the security update for Remote Desktop client 6.1 and Remote Desktop client 6.0: March 8, 2011

[2462310](https://support.microsoft.com/help/2462310) A 16-bit application that uses initialization (.ini) files does not work correctly in a Windows Server 2008 x86 Terminal Services session

[982303](https://support.microsoft.com/help/982303) Terminal Services performance counters report an incorrect number of sessions when a heavy load situation occurs in Windows Server 2008 R2 or in Windows Server 2008

[978829](https://support.microsoft.com/help/978829) The CTRL and ALT keys in a Terminal Service session get stuck when you unlock a local computer

[971338](https://support.microsoft.com/help/971338) The terminal server roaming profile of a user account is not loaded correctly on a terminal server that is running Windows Server 2008 R2 or Windows Server 2008 after the user password is changed during session logon

[971253](https://support.microsoft.com/help/971253) You receive a blank screen when you log on to a terminal server that is running Windows Server 2008

[970089](https://support.microsoft.com/help/970089) A hotfix is available that addresses occasional crashes of Vmwp.exe processes on a Windows Server 2008-based Hyper-V host computer

[970067](https://support.microsoft.com/help/970067) You find high CPU usage for the Wmiprvse.exe process on a terminal server that is running Windows Server 2008 when you run the Windows System Resource Manager

[969940](https://support.microsoft.com/help/969940) When you start a terminal session to a computer that is running Windows Server 2008 and that has the terminal server role installed, the full Windows desktop starts instead of the program that is specified by the terminal server

[941641](https://support.microsoft.com/help/941641) Remote Desktop Connection 6.0 prompts you for credentials before you establish a remote desktop connection

## Device Redirection & Printing

[2655998](https://support.microsoft.com/help/2655998) Long logon time when you establish an RD session to a Windows Server 2008 R2-based RD Session Host server if Printer Redirection is enabled

[2620656](https://support.microsoft.com/help/2620656) Invalid redirected printers may be available in a Remote Desktop Services session that connects to a RD Session Host server that is running Windows server 2008 or Windows Server 2008 R2

[2532459](https://support.microsoft.com/help/2532459) Print queue does not work if the queue is not one of the first 100 queues installed in a Windows Server 2008 or Windows Server 2008 R2 Terminal Services session

[2059743](https://support.microsoft.com/help/2059743) You cannot print to multiple trays in a terminal server session in Windows Server 2008

[981650](https://support.microsoft.com/help/981650) You cannot print text in a terminal server session in Windows Server 2003, in Windows Server 2008, or in Windows Vista if the printer uses the "Generic / Text Only" driver

[979163](https://support.microsoft.com/help/979163) Many pages are printed when you try to print an Excel worksheet by using a redirected printer if the Terminal Services Easy Print feature is used

### Licensing

[2028637](https://support.microsoft.com/help/2028637) A domain administrator or local administrator incorrectly receives a warning message "Cannot find a valid Terminal Services Licensing Server" when this user account logs on to a Windows Server 2008 Terminal server

[2021885](https://support.microsoft.com/help/2021885) Terminal Server License Server/Remote Desktop License Server Only Issuing Temporary Licenses and Event ID 17 Logged

[983385](https://support.microsoft.com/help/983385) Event ID 17 is logged in the System log on a TS Licensing server or on a RD Licensing server in Windows Server 2003 SP2, in Windows Server 2008, or in Windows Server 2008 R2

[979548](https://support.microsoft.com/help/979548) You cannot enter an agreement number of a volume license that contains more than seven digits in Remote Desktop Licensing Manager or in TS Licensing Manager

[972069](https://support.microsoft.com/help/972069) A terminal server that is running Windows Server 2008 cannot obtain terminal licenses from a Terminal Server license server that is running Windows Server 2008 after you enable the "License Server Security Group" Group Policy setting

[971302](https://support.microsoft.com/help/971302) Single CALs support is available for Terminal Server license servers that are running Windows Server 2008

[968074](https://support.microsoft.com/help/968074) An update is available that enables the Terminal Services license servers that are running Windows Server 2008 to be able to use the CALs for the Windows Server 2008 R2 Remote Desktop Services

## TS Gateway

[2620264](https://support.microsoft.com/help/2620264) You cannot start any RemoteApp applications through a Windows Server 2008-based TS gateway

## TS RemoteApp

[2579055](https://support.microsoft.com/help/2579055) A started RemoteApp application is intermittently not visible in Windows Server 2008

[2381675](https://support.microsoft.com/help/2381675) The RemoteApp program is not terminated after the idle session time limit expires on a computer that is running Windows Server 2008

[983533](https://support.microsoft.com/help/983533) The pop-up windows are hidden and the TS RemoteApp application stops responding in Windows Vista, in Windows 7, in Windows Server 2008, and in Windows Server 2008 R2

[979425](https://support.microsoft.com/help/979425) A combo box item in a RemoteApp application is updated incorrectly when you connect by using Remote Desktop Connection (RDC) 7.0

[970689](https://support.microsoft.com/help/970689) A Windows Server 2008-based terminal server denies connection requests with the error message "The remote procedure call failed and did not execute" randomly under a heavy logon/logoff condition

## TS Session Broker

[2522829](https://support.microsoft.com/help/2522829) Sessions are not correctly distributed after the Terminal Services Session Broker service runs for 25 or more days consecutively in Windows Server 2008

## TS Web Access

[951607](cannot-connect-to-remote-computer.md) You cannot connect to a remote computer or start a remote application when you use Terminal Services Web Access or Remote Web Workspace on a Windows XP SP3-based or Windows Small Business Server 2003 SP1-based computer

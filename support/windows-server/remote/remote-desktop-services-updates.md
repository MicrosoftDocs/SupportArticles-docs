---
title: Available updates for RDS
description: Summarizes the available hotfixes and updates for issues that occur in Remote Desktop Services (Terminal Services) for Windows Server 2008 R2 environments.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Remote Desktop Services and Terminal Services\Deployment, configuration, and management of Remote Desktop Services infrastructure, csstroubleshoot
---
# Available updates for Remote Desktop Services (Terminal Services) in Windows Server 2008 R2 SP1

This article lists the available hotfixes and updates for issues that occur in Remote Desktop Services (Terminal Services) for Windows Server 2008 R2.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2601888

## Summary

This article summarizes the available hotfixes and updates for issues that can occur in Remote Desktop Services (Terminal Services) for Windows Server 2008 R2 environments.

For Windows Server 2012 Remote Desktop Services updates, see [Available updates for Remote Desktop Services in Windows Server 2012](windows-server-2012-rds-updates.md).

For Windows Server 2012 R2 Remote Desktop Services updates, see [KB2933664](https://support.microsoft.com/help/2933664).

> [!NOTE]
> This list is an aggregate of common issues seen with Remote Desktop Services (Terminal Services) in Windows Server 2008 R2. *Don't proactively install the following patches unless needed*. If you believe that you're experiencing an issue listed below, install just the hotfix for that specific issue. If the specific hotfix is listed for your issue, we recommend that you evaluate these hotfixes and updates to determine if they apply to a specific Windows version and Service Pack level.

The hotfixes and updates are arranged by component areas within Remote Desktop Services 2008 R2 environments and could apply to Windows XP, Windows Vista, and Windows 7 Remote Desktop Clients.

VDI: Many of the hotfixes listed below are also applicable to Windows 7 machines that are being used as VDI guests and the 2008 R2 RDS component areas. Review the hotfixes to see if they're also applicable for Windows 7.

## Authentication

- [2752618](https://support.microsoft.com/help/2752618)  RDS client computer cannot connect to the RDS server by using a remote desktop connection in Windows 7 or in Windows Server 2008 R2

- [2548538](https://support.microsoft.com/help/2548538)  Smart card authentication does not work when you use VDI and RD Gateway for RDC client in Windows 7 or in Windows Server 2008 R2

- [2524668](https://support.microsoft.com/help/2524668)  The single sign-on feature does not work in Windows 7 or in Windows Server 2008 R2 when you try to start a full remote desktop connection through RD Web Access

- [2521923](https://support.microsoft.com/help/2521923)  A program that requires you to use a smart card stops responding in a remote desktop connection in Windows Server 2008, in Windows Vista, in Windows 7 or in Windows Server 2008 R2

- [2301288](https://support.microsoft.com/help/2301288)  A Remote Desktop Services session is disconnected automatically if you apply the "Interactive logon: smart card removal behavior" Group Policy setting in Windows Server 2008 R2 or in Windows 7

## General OS updates

- [2847932](https://support.microsoft.com/help/2847932) Language switch fails in a RD session and shortcut menu is not displayed in a RemoteApp session in Windows 7 SP1 or Windows Server 2008 R2 SP1

- [2846226](https://support.microsoft.com/help/2846226) Stop Error 0x0000008E on a computer that is running Windows 7 SP1 or Windows Server 2008 R2 SP1

- [2834976](https://support.microsoft.com/help/2834976) Authenticated users are removed from the Remote Desktop Users group after you set the drain mode on a Windows Server 2008 R2-based RDS server

- [2831347](https://support.microsoft.com/help/2831347) Roaming user profiles are corrupted when a monitoring program executes a WMI query on a Windows Server 2008 R2 SP1-based RDS server

- [2823176](https://support.microsoft.com/help/2823176) User sessions may be logged off unexpectedly when duplicate IP addresses are detected in Windows Multipoint Server 2011

- [2780102](https://support.microsoft.com/help/2780102)0x0000003B Stop error when a Remote Desktop Connection Broker and a Windows 7 SP1 or Windows Server 2008 R2 SP1-based computer are in an RDS farm

- [2769791](https://support.microsoft.com/help/2769791)  Windows Audio service stops on Windows Server 2008 R2-based computer after you configure remote audio playback

- [2769372](https://support.microsoft.com/help/2769372)  Windows Remote Assistance fails in Windows 7 SP1 or Windows Server 2008 R2 SP1

- [2768741](https://support.microsoft.com/help/2768741)  Visual elements are displayed incorrectly when you connect to a computer that is running Windows 7 or Windows Server 2008 R2 by using the Remote Desktop Protocol

- [2750090](https://support.microsoft.com/help/2750090)  High CPU utilization by the Svchost.exe process and the Lsass.exe process in the Remote Desktop session after you remotely connect to a computer that is running Windows 7 or Windows Server 2008 R2

- [2749262](https://support.microsoft.com/help/2749262)  Remote Desktop Configuration service crashes together with event ID 1000 in Windows Server 2008 R2

- [2726399](https://support.microsoft.com/help/2726399)  You cannot change the DPI setting through a Remote Desktop session on a computer that is running Windows 7 or Windows Server 2008 R2

- [2719704](https://support.microsoft.com/help/2719704)0x0000003B or 0x000000D5 Stop error in Windows 7 or in Windows Server 2008 R2

- [2685909](https://support.microsoft.com/help/2685909)  Poor performance occurs when you shadow a Remote Desktop session in Windows Server 2008 R2 or in Windows 7

- [2666484](https://support.microsoft.com/help/2666484)0x0000003B Stop error on Windows Server 2008 R2-based RD Session Host servers that use an RD Connection Broker

- [2665720](https://support.microsoft.com/help/2665720)  Remote Assistance does not display a desktop that has a resolution of 1366 x 768 correctly in Windows 7

- [2665347](https://support.microsoft.com/help/2665347)  You cannot connect to a virtual machine by using the Hyper-V Manager MMC snap-in in Windows Server 2008 R2

- [2661332](https://support.microsoft.com/help/2661332)  You cannot reestablish a Remote Desktop Services session to a Windows Server 2008 R2-based server

- [2661001](https://support.microsoft.com/help/2661001) Please wait for Local Session Manager message remains for several minutes when you disconnect from a computer that is running Windows Server 2008 R2 during the logon process

- [2648397](https://support.microsoft.com/help/2648397)  You cannot change an expired user account password in a Remote Desktop session from a client computer that is running Windows 7 or Windows Server 2008 R2

    > [!NOTE]
    > This is a client-side fix, see [2648402](https://support.microsoft.com/help/2648402) for server-side fix.

- [2647582](https://support.microsoft.com/help/2647582)  You cannot update the Group Policy settings on a Windows Server 2008 R2-based RD Session Host server if IP Virtualization is applied

- [2647452](https://support.microsoft.com/help/2647452)  Paged pool leaks when you map a network drive and then disconnect it frequently in Windows 7 or in Windows Server 2008 R2

- [2647409](https://support.microsoft.com/help/2647409)  Remote Desktop Services sessions are not kept alive as expected in Windows Server 2008 R2

- [2622802](https://support.microsoft.com/help/2622802)  The Group Policy Client service crashes on a terminal server that is running Windows Server 2008 or Windows Server 2008 R2 when multiple users connect to the server at the same time

- [2619880](https://support.microsoft.com/help/2619880) The network path was not found error message when you start a LDAP-related application in Windows Server 2008 R2

- [2617878](https://support.microsoft.com/help/2617878)  You cannot set the LogonTimeout setting after the default RDP listener (RDP-Tcp) is deleted in Windows Server 2008 R2

- [2617687](https://support.microsoft.com/help/2617687)  Applications or services that start multiple Remote Desktop Services sessions crash in Windows 7 or in Windows Server 2008 R2

- [2615701](https://support.microsoft.com/help/2615701) Logon Process Initialization Failure error message and the logon process does not start in Windows 7 or in Windows Server 2008 R2

- [2585853](https://support.microsoft.com/help/2585853)  Choppy video playback when you play a high-definition video over a remote desktop connection in Windows 7 or in Windows Server 2008 R2

- [2582172](https://support.microsoft.com/help/2582172)  Remote desktop is not displayed in Full-Screen mode when the screen resolution is 1366× 768 pixels in Windows 7 or in Windows Server 2008 R2

- [2578159](https://support.microsoft.com/help/2578159)  The logon process stops responding in Windows Server 2008 R2 or in Windows 7

- [2575946](https://support.microsoft.com/help/2575946) Limit the size of the entire roaming user profile cache Group Policy setting does not work in Windows Server 2008 R2

- [2571388](https://support.microsoft.com/help/2571388)  A Remote Desktop Services session stops responding during the logoff process in Windows Server 2008 R2

- [2545735](https://support.microsoft.com/help/2545735)"The home folder could not be created" error when an administrator tries to set Remote Desktop Services Home Folder for a user account in Windows 7 or in Windows Server 2008 R2

- [2525246](https://support.microsoft.com/help/2525246)0x0000003B Stop error when you remotely control a Remote Desktop session in Windows Server 2008 R2

- [2519550](https://support.microsoft.com/help/2519550)  An incorrect program icon appears on the task bar in a remote desktop session that is running in Windows 7 or in Windows Server 2008 R2

- [2492765](https://support.microsoft.com/help/2492765)  User account passwords can be changed in the Sysprep Specialize phase of Sysprep.exe in Windows Server 2008 or in Windows Server 2008 R2

- [2479710](https://support.microsoft.com/help/2479710)  Remote Desktop service crashes when Group Policy settings are refreshed in Windows Server 2008 R2 after you enable the Required secure RPC communication and Set client connection encryption level Group Policy settings

- [2446026](https://support.microsoft.com/help/2446026)  An application that uses the Remote Desktop Connection ActiveX control to provide virtualized sessions crashes in Windows Server 2008 R2 or in Windows 7

## Device Redirection and Printing

- [2871131](https://support.microsoft.com/help/2871131) The size of the HKEY_USERS\.DEFAULT registry hive continuously increases on a Windows Server-based server

- [2778831](https://support.microsoft.com/help/2778831) Client Side Rendering Print Provider registry key growth on a Windows Server 2008 R2-based Remote Desktop Session Host server

- [2769791](https://support.microsoft.com/help/2769791) Windows Audio service stops on Windows Server 2008 R2-based computer after you configure remote audio playback

- [2662585](https://support.microsoft.com/help/2662585)  Printer redirection is not applied to client computers that connect to a Windows Server 2008 R2 SP1-based Terminal Services server

- [2655998](https://support.microsoft.com/help/2655998)  Long logon time when you establish an RD session to a Windows Server 2008 R2-based RD Session Host server if Printer Redirection is enabled

- [2620656](https://support.microsoft.com/help/2620656)  Invalid redirected printers may be available in a Remote Desktop Services session that connects to a RD Session Host server that is running Windows Server 2008 or Windows Server 2008 R2

- [2538047](https://support.microsoft.com/help/2538047)  Audio capture redirection feature does not work after a second remote desktop connection is created in Windows Server 2008 R2

## RemoteApp

- [2862019](https://support.microsoft.com/help/2862019) A RemoteApp application main window takes the focus after the applications windows are maximized in Windows

- [2835429](https://support.microsoft.com/help/2835429) The taskbar is hidden when a screen resolution of 1366 x 768 is used for a RemoteApp application that is running on Windows Server 2008 R2

- [2798286](https://support.microsoft.com/help/2798286) RemoteApp application session disconnects from a client computer that is running Windows 7 or Windows Server 2008 R2

- [2699817](https://support.microsoft.com/help/2699817)  RemoteApp session is disconnected when the RDP encryption level is set to Low and RDP compression is disabled in Windows Server 2008 R2

- [2636613](https://support.microsoft.com/help/2636613)  Rdpshell.exe process leaks memory in Windows Server 2008 R2 when you move a published RemoteApp application's window on the client side

- [2614136](https://support.microsoft.com/help/2614136)  Some windows of a Remote Desktop Services (Terminal Services) RemoteApp application might not be displayed correctly in Windows 7 or in Windows Server 2008 R2

- [2604066](https://support.microsoft.com/help/2604066)  The top-level window of a RemoteApp application becomes unresponsive in Windows Server 2008 R2 or in Windows 7

- [2580346](https://support.microsoft.com/help/2580346)  Some pop-up windows of a Remote Desktop Services (Terminal Services) RemoteApp application might be hidden in Windows 7 or in Windows Server 2008 R2

- [2526629](https://support.microsoft.com/help/2526629)  The logon message is not displayed correctly when you connect to a RemoteApp application from a computer that has multiple monitors and that is running Windows 7 or Windows Server 2008 R2

- [2522762](https://support.microsoft.com/help/2522762)  RemoteApp application does not work correctly from RD Web Access in Windows 7 or in Windows Server 2008 R2

- [2522743](https://support.microsoft.com/help/2522743)  You cannot use a calendar control in a RemoteApp application when you use the RDC 7.0 client to connect to the RemoteApp application from a computer that is running Windows 7 or Windows Server 2008 R2

- [981156](https://support.microsoft.com/help/981156)  RemoteApp applications are displayed as black windows when you restart the applications in a Remote desktop connection in Windows Server 2008 R2

## RemoteFX

[2519946](https://support.microsoft.com/help/2519946)  Timeout Detection and Recovery (TDR) randomly occurs in a virtual machine that uses the RemoteFX feature in Windows Server 2008 R2

## Remote Desktop Connection Broker

[2536840](https://support.microsoft.com/help/2536840)  IP addresses that are used for reconnection are not listed completely in the RD Connection Broker setting in Windows Server 2008 R2 or in Windows 7

## Remote Desktop Gateway

- [2778863](https://support.microsoft.com/help/2778863)  RD Gateway service crashes on a computer that is running Windows Server 2008 R2

- [2770175](https://support.microsoft.com/help/2770175)  RD Gateway service crashes when a client computer tries to connect to a Windows Server 2008 R2 SP1-based terminal server

- [2649422](https://support.microsoft.com/help/2649422)  External users cannot connect to RDS that are published on a Windows Server 2008 R2-based RD Gateway server through Forefront UAG

- [2620264](https://support.microsoft.com/help/2620264)  You cannot start any RemoteApp applications through a Windows Server 2008-based or Windows Server 2008 R2-based TS gateway

- [2578133](https://support.microsoft.com/help/2578133)  The Remote Desktop Gateway service incorrectly blocks a user account whose name contains localized characters in Windows Server 2008 R2

- [2497787](https://support.microsoft.com/help/2497787)  The Remote Desktop Gateway service crashes under a heavy workload in Windows Server 2008 R2

## Remote Desktop Web Access

- [2793072](https://support.microsoft.com/help/2793072) Generic error message when you change your password on a RD Web Access website in Windows Server 2008 R2 or Windows Server 2012

- [2705427](https://support.microsoft.com/help/2705427)  The Remote Desktop Web Access website does not show any published RemoteApp programs if a RemoteApp source is offline in Windows Server 2008 R2

- [2648402](https://support.microsoft.com/help/2648402)  You cannot change an expired user account password in a remote desktop session that connects to a Windows Server 2008 R2-based RD Session Host server in a VDI environment

    > [!NOTE]
    > This is a server-side fix, see [2648397](https://support.microsoft.com/help/2648397) for client-side fix.

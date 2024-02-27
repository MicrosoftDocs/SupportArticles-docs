---
title: Recommended updates for RDS in Windows Server 2012 R2
description: Describes the hotfixes and updates that are currently available for Remote Desktop Services in Windows Server 2012 R2.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, darank
ms.custom: sap:administration, csstroubleshoot
---
# Recommended hotfixes and updates for Remote Desktop Services in Windows Server 2012 R2

This article describes the hotfixes and updates that are currently available for Remote Desktop Services in Microsoft Windows Server 2012 R2.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3147099

## Summary

This article describes the currently available fixes that are highly recommended for Remote Desktop Services in Windows Server 2012 R2 environments. These fixes have [prerequisites for all Remote Desktop Services roles](#prerequisites), and they apply to the following areas for Remote Desktop Services 2012 R2:

- Remote Desktop Connection Brokers
- Remote Desktop Gateway
- Remote Desktop Licensing
- Remote Desktop Session Hosts
- Remote Desktop Virtualization Hosts
- Remote Desktop Web Access

Additional Remote Desktop client information is introduced:

- RDP 8.1 updates for Windows 7
- RDP 8.1 and 8.0 new features

> [!NOTE]
> We recommend that you install these fixes to ensure the highest level of reliability.

For a complete list of all available fixes, see [Available Updates for Remote Desktop Services in Windows Server 2012 R2](https://support.microsoft.com/help/2933664).

## Prerequisites

Before you install the hotfix for any Remote Desktop Services role, you must have the following updates installed.

|Date the update was added|Related Knowledge Base article|Title|Component|Why we recommend this update|
|---|---|---|---|---|
|Ongoing|Any remaining Windows updates|N/A|Multiple|The most recent Windows updates and fixes outside of normal security updates, in addition to the rollup packages that are listed in this table.|
|December 2014| [3013769](https://support.microsoft.com/help/3013769)|December 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2|Multiple|An update rollup package that resolves issues and includes performance and reliability improvements. Available from Windows Update and for individual download from the Microsoft Download Center. To apply this update, you must first install the update [2919355](https://support.microsoft.com/help/2919355) on Windows Server 2012 R2.|
|November 2014| [3000850](https://support.microsoft.com/help/3000850)|November 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2|Multiple|A cumulative update that includes the security updates and non-security updates (including for Remote Desktop Services) that were released between April 2014 and November 2014. Available from Windows Update and for individual download from the Microsoft Download Center. To apply this update, you must first install the update [2919355](https://support.microsoft.com/help/2919355) on Windows Server 2012 R2.|

## Updates and hotfixes for Remote Desktop Connection Brokers

> [!NOTE]
> See the [prerequisites table](#prerequisites) before you install any update or hotfix for this server role.

|Date the update was added|Related Knowledge Base article|Title|Component|Why we recommend this update|
|---|---|---|---|---|
|November 2015| [3091411](https://support.microsoft.com/help/3091411)|User connection fails when many connections are made to Windows Server 2012 R2-based RD Connection Broker|Multiple|This rollup contains the following improvements:<ul><li> Improves the number of successful user connections when many user connections exist (especially during peak logon periods).</li><li> Decreases CPU usage on SQL Server that's used in a High Availability-based Connection Broker deployment.</li><li> Optimizes the number of SQL calls that are invoked by Connection Broker when it processes RD user connections. This hotfix improves the overall performance of the Connection Broker by scaling more user connections that typically occur during peak logon periods.</li></ul>|
|December 2014| [3020474](communication-issues.md)|Communication issues occur when Remote Desktop Connection Broker connects to SQL Server in Windows Server 2012 R2|script|If you are using RD Connection Broker High Availability, make sure that you watch for the security events that are described in the Knowledge Base article that indicate communication issues between the RD Connection Brokers and SQL Server. You have to enable auditing for failure events by using the script `auditpol /set /subcategory:"Filtering Platform Connection" /success:disable /failure:enable` <br/><br/> This script unblocks only UDP port 1434 from a Windows level. If you have a network device that also blocks this port, you must unblock at this level, too.|

## Updates and hotfixes for Remote Desktop Gateway

> [!NOTE]
> See the [prerequisites table](#prerequisites) before you install any update or hotfix for this server role.

|Date the update was added|Related Knowledge Base article|Title|Component|Why we recommend this update|
|---|---|---|---|---|
|March 2016| [3123913](https://support.microsoft.com/help/3123913)|Remote Desktop Gateway server crashes during certain user disconnect scenarios in Windows Server 2012 R2|aaedge.dll|Latest version of Aaedge.dll that resolves several issues in which the RD Gateway service crashes and causes user disconnections. Also includes [3042843](https://support.microsoft.com/help/3042843).|

## Updates and hotfixes for Remote Desktop Licensing

> [!NOTE]
> See the [prerequisites table](#prerequisites) before you install any update or hotfix for this server role.

|Date the update was added|Related Knowledge Base article|Title|Component|Why we recommend this update|
|---|---|---|---|---|
|March 2016| [3108326](https://support.microsoft.com/help/3108326)|Licensing servers become deadlocked under high load in Windows Server 2012 R2|lserver.dll|Latest version of Lserver.dll that resolves an issue in which multiple RD Licensing servers crash or restart on high load. Any RDSH that is configured in Per-Device mode would refuse all connections requests while their LS is in this state. Also includes [3092695](https://support.microsoft.com/help/3092695) and [3084952](https://support.microsoft.com/help/3084952). |
|January 2015| [3013108](https://support.microsoft.com/help/3013108)|RDS License Manager shows no issued free or temporary client access licenses in Windows Server 2012 R2|licmgr.exe|Latest version of Licmgr.exe that fixes an issue in which the RDS License Manager shows no issued free or temporary client access licenses in Windows Server 2012 R2.|

## Updates and hotfixes for Remote Desktop Session Hosts

> [!NOTE]
> See the [prerequisites table](#prerequisites) before you install any update or hotfix for this server role.

|Date the update was added|Related Knowledge Base article|Title|Component|Why we recommend this update|
|---|---|---|---|---|
|April 2016| [3146978](https://support.microsoft.com/help/3146978)|RDS redirected resources showing degraded performance in Windows 8.1 or Windows Server 2012 R2|Multiple|This update resolves slow RDP performance issues when you use redirected resources (drives, printers, and ports).|
|December 2015| [3127673](https://support.microsoft.com/help/3127673)|Stop error 0x000000C2 or 0x0000003B when you're running Remote Desktop Services in Windows Server 2012 R2|win32k.sys & dxgkrnl.sys|This article describes a hotfix package that fixes a problem that causes Windows Server 2012 R2 to crash when you're running Microsoft Remote Desktop Services (RDS).|
|October 2015| [3103000](https://support.microsoft.com/help/3103000)|RemoteApp windows disappear and screen flickers when you switch between windows in Windows 8.1 or Windows Server 2012 R2|rdpshell.exe|This update contains the latest RemoteApp server side components (mainly Rdpinit.exe/Rdpshell.exe) and includes all other RemoteApp section fixes that are listed in [2933664](https://support.microsoft.com/help/2933664).<br/><br/>There may also be fixes on the client side for RemoteApp. These fixes are listed again in [2933664](https://support.microsoft.com/help/2933664) in the **Remote Desktop Client** section.|
|September 2015| [3092688](https://support.microsoft.com/help/3092688)|UPD profiles corrupted when a network connectivity issue occurs in Windows Server 2012 R2|sessenv.dll|Latest version of Sessenv.dll. This update resolves an issue in which UPDs become corrupted when network connectivity issue occurs.|
|July 2015| [3078676](https://support.microsoft.com/help/3078676)|Event 1530 is logged and ProfSvc leaks paged pool memory and handles in Windows 8.1 or Windows Server 2012 R2|profsvc.dll|Latest version of Profsvc.dll. This article describes an issue in which event 1530 is logged, and the User Profile Service (ProfSvc) leaks paged pool memory and handles.|
|July 2015| [3073630](https://support.microsoft.com/help/3073630)|Remote Desktop Easy Print runs slowly in Windows Server 2012 R2|Multiple|Resolves an issue in which it takes a long time to print through a redirected printer that uses Remote Desktop Easy Print.|
|July 2015| [3073629](https://support.microsoft.com/help/3073629)|Redirected printers go offline after print spooler is restarted on a Windows Server 2012 R2-based RD Session Host server|Multiple|Resolves an issue in which redirected printers go offline after the print spooler is restarted on a Windows Server 2012 R2-based RD Session Host server. Also includes [3055615](https://support.microsoft.com/help/3055615).|

## Updates and hotfixes for Remote Desktop Virtualization Hosts

> [!NOTE]
> See the [prerequisites table](#prerequisites) before you install any update or hotfix for this server role.

|Date the update was added|Related Knowledge Base article|Title|Component|Why we recommend this update|
|---|---|---|---|---|
|November 2015| [3092688](https://support.microsoft.com/help/3092688)|UPD profiles corrupted when a network connectivity issue occurs in Windows Server 2012 R2|sessenv.dll|Latest version of Sessenv.dll. This update resolves an issue in which UPDs become corrupted when network connectivity issue occurs.<br/><br/>If the VDI guest VMs are running Windows 8.1, you must also install this within the guest virtual machines.|

## Updates and hotfixes for Remote Desktop Web Access

> [!NOTE]
> See the [prerequisites table](#prerequisites) before you install any update or hotfix for this server role.

|Date the update was added|Related Knowledge Base article|Title|Component|Why we recommend this update|
|---|---|---|---|---|
|November 2015| [3069129](https://support.microsoft.com/help/3069129)|Blank page is displayed when you try to access RemoteApps on a Windows-based RD Web Access server|Multiple|Resolves an issue in which the RD Web Access server displays a blank web page if the number of published RemoteApps is greater than 999. Also includes the update 2957984.|

## Remote Desktop clients (mstsc.exe)

- **RDP 8.1 updates for Windows 7**

    These fixes update the Remote Desktop Services server-side roles and components that are built around Remote Desktop Protocol (RDP) 8.1. However, although updates are performed on the server-side infrastructure, the Remote Desktop Clients are often left untouched. This can cause performance and reliability issues. By default, older clients such as Windows 7 Service Pack 1 (SP1) are restricted to RDP 7.1 and do not provide the new features and improvements that are available in RDP 8.1. Therefore, we have released the RDP 8.1 client for Windows 7 to provide significant performance and reliability improvements when these clients are connected to RDS 2012 R2 environments. To enable RDP 8.1 on Windows 7, follow these steps:

    1. Verify which version of RDP you're using. To do this, start the Remote Desktop Connection client program (mstsc.exe), click the small Remote Desktop icon in the top-left corner of the application dialog box, and then select **About**. Verify that the **About** message indicates _Remote Desktop Protocol 8.1 supported_.

        :::image type="content" source="media/remote-desktop-services-updates/verify-rdp-version.png" alt-text="Screenshot of the About Remote Desktop Connection window, which shows Remote Desktop Protocol 8.1 supported.":::

    2. If the About message indicates Remote Desktop Protocol 7.1 supported, install the following updates for RDP 8.1:

        - [2574819](https://support.microsoft.com/help/2574819): An update is available that adds support for DTLS in Windows 7 SP1 and Windows Server 2008 R2 SP1

        - [2857650](https://support.microsoft.com/help/2857650): Update that improves the RemoteApp and Desktop Connections features is available for Windows 7

        - [2830477](https://support.microsoft.com/help/2830477): Update for RemoteApp and Desktop Connections feature is available for Windows

        - [2913751](https://support.microsoft.com/help/2913751): Smart card redirection in remote sessions fails in a Windows 7 SP1-based RDP 8.1 client

        - [2923545](https://support.microsoft.com/help/2923545): Update for RDP 8.1 is available for Windows 7 SP1.31255

    3. [3125574](https://support.microsoft.com/help/3125574): Convenience rollup update for Windows 7 SP1 and Windows Server 2008 R2 SP1

    4. Install any outstanding Windows Updates.

- **RDP 8.1 and RDP 8.0 new features**

    For a list of features that were introduced in RDP 8.1, see [Update for RemoteApp and Desktop Connections feature is available for Windows](https://support.microsoft.com/help/2830477).

    For a list of features that were introduced in RDP 8.0, see [Remote Desktop clients](/windows-server/remote/remote-desktop-services/clients/remote-desktop-clients#bookmark-new-features).

---
title: Terminal Server licensing
description: Describes Terminal Server licensing.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, willgloy
ms.custom: sap:remote-desktop-services-terminal-services-licensing, csstroubleshoot
ms.subservice: rds
---
# Terminal Server licensing

This article describes Terminal Server licensing. Terminal Server's licensing requirements are different from those of Microsoft Windows NT Server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 187629

## Licenses to connect to Terminal Server

Terminal Server Clients require two licenses to connect to a Terminal Server.

The first license is a Windows NT Workstation license. This is necessary because the Terminal Server Client effectively provides a Windows NT Workstation to the client. If the RDP client is run on a computer running Windows NT 4.0 (Server, Workstation, or Terminal Server) client already purchased the license, and it is not necessary to purchase an additional Windows NT Workstation. If the RDP client is run on a Windows NT 3.5x computer, then that client requires a Windows NT Workstation Upgrade license. If the RDP client is run on a Windows 95 or Windows for Workgroups 3.11 computer, then the client requires a Windows NT Workstation full license. These three license types are displayed in Terminal Server License Manager. In the right pane of the display, notice that the first license category of existing Windows NT Workstation licenses is "unlimited." The Full and Upgrade license types, however, will display how many licenses have been purchased and entered into Terminal Server License Manager.

The second license is a Client Access License for the server. This is the standard server access license measured in License Manager, the same utility that is in Windows NT Server. License Manager does not distinguish between RDP client access and other types of server access (for example, it does not distinguish between a normal shared file and printer resource access). **Per Server** and **Per Seat** modes are identical to those of Windows NT Server 4.0.

## Client Access Licenses in License Manager

Terminal Server License Manager reports but does not enforce licensing. Enforcement comes from the License Manager in Windows NT. If an RDP client is denied access to the server when it tries to make a connection, increasing the license count in Terminal Server License Manager will not resolve the problem. Client Access Licenses must be added to License Manager.

If License Manager denies an RDP client access, the event will be recorded as event 201 in the Event Log. The event message will show that a license was not available for SYSTEM to access the TermService.

If Client Access Licenses are available in License Manager, and Terminal Server License Manager runs out of needed licenses, a temporary license will be granted. In this case, a fourth and fifth category of license can appear in Terminal Server License Manager: Temporary Windows NT Workstation Full license, or Temporary Windows NT Workstation Upgrade license. These licenses are good for 60 days. The RDP client making use of a temporary license will continue to do so for the full 60 days even if new licenses are added. After 60 days, the client's temporary license will expire, and the client will get a new license (either a temporary license if no normal licenses are available, or one of the new licenses that have been added).

> [!NOTE]
> Logging on at the Terminal Server console uses one Client Access License, but this is not reflected in the license count in License Manager. In the event that only one Client Access License is available, RDP clients (at the console or elsewhere) will not be able to connect even though the License Manager in-use license count is zero.

If no Client Access Licenses are available, not even the administrator can connect through the RDP client. This is different from normal licensing behavior because administrators can always log on at the console or connect to the server remotely even if no licenses are available. Administrators must log on at the Terminal Server console, or access the server by means other than the RDP client, if the Terminal Server runs out of licenses.

When an RDP client is denied access, the client will receive the generic message: Terminal Server has ended the connection.

License information is recorded on the Terminal Server, Windows NT, and Windows 95 computers under `HKEY_LOCAL_MACHINE\Software\Microsoft\MSLicensing`.

Licenses are stored on the Terminal Server in the `%systemroot%\system32\lserver` directory in the hydra.mdb file. Computers running Windows for Workgroups 3.11 store licensing information in the *.bin files in the Regdata directory under System. The typical path is `C:\Windows\System\Regdata`.

Terminal Server License Manager creates seven temporary files in the System32 directory. The temporary files are called JET1.TMP through JET7.TMP. These files are used to temporarily store newly created licenses.

It is possible to have more than seven JETx.TMP files. If the server is powered off without using the shutdown routine or if the server is shut down inside an RDP client session, the JETx.TMP files are not cleaned up. Shutting down the server through an RDP client session is generally not an issue, since services are written to handle power outages by committing cached data very quickly. Administrators should be aware, however, that the normal shutdown procedures are not followed. If you shut down the server at the console, all services are stopped before the server shuts down. The server shuts down immediately, without stopping services correctly if the shutdown is performed through a client session. Because services are not notified, the JETx.TMP files will already exist when the server is restarted. The Terminal Server License Manager service will create seven new JETx.TMP files.

If JETx.TMP files numbered 1-7 exist, the server will create new files numbered 8-14. If you deleted files 1-7 (which could be done since they would not be open) and shutdown the system through the RDP client again, the new files created at startup would again be numbered 1-7. So, the highest numbered files are not necessarily the files that are in use.

If left over JETx.TMP files are an issue, delete JET*.TMP files. Only the closed, unused files will be deleted. You cannot delete open files, or delete files in use.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#terminal-server-licensing).

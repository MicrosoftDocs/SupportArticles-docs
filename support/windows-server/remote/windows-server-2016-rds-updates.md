---
title: Available Remote Desktop Services updates in Windows Server 2016
description: Introduce recommended hotfixes and updates for Remote Desktop Services in Windows Server 2016.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:administration, csstroubleshoot
ms.subservice: rds
---
# Available Remote Desktop Services updates in Windows Server 2016

This article introduces the recommended hotfixes and updates for Remote Desktop Services in Windows Server 2016.

_Applies to:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4039839

## Summary  

This article describes the fixes that are available for issues that can occur in Remote Desktop Services in Windows Server 2016 environments. Installing the most recent cumulative update for Windows Server 2016 from [Windows 10 and Windows Server 2016 update history](https://support.microsoft.com/help/4000825/windows-10-windows-server-2016-update-history) ensures that you also install any previous updates that you might have missed, including any important security fixes.

See the [Release Date](#release-date) or the [Component Area](#component-area) section for details.

For Windows Server 2012 R2 Remote Desktop Services updates, see [Available Updates for Remote Desktop Services in Windows Server 2012 R2](https://support.microsoft.com/help/2933664).

## Release date  

September 2018  

- Addresses an issue that causes a Remote Desktop Session Host server to occasionally stop responding during login.  
- ​​ Addresses an issue that causes login to fail when using a smart card to log in to a Remote Desktop Server. The error is "STATUS_LOGON_FAILURE".  
- Addresses an issue that displays the report date as "Unknown" in the Remote Desktop License Manager. ​  
- Makes the visibility Group Policy for the Settings Page available under User Configuration and Computer Configuration. The GPOs are at the following paths: ​  
  - User Configuration/Administrative Template/Control Panel/Settings Page Visibility.  
  - Computer Configuration/Administrative Template/Control Panel/Settings Page Visibility.  

To fix these issues, install [September 20, 2018 Windows Cumulative Update](https://support.microsoft.com/help/4457127).  

August 2018  

- Addresses an issue when TS Gateway service crashes in aaedge.dll due to NULL deref 
- ​ Addresses a system crash (Stop 3B) in win32kfull.sys when canceling journal hook operations or disconnecting a remote session. ​  
- Addresses an issue in a Remote Desktop VDI deployment that prevents a mounted UPD from disconnecting, which results in the creation of temp files.  
- ​ Addresses an issue that causes a connection failure when a Remote Desktop connection doesn't read the bypass list for a proxy that has multiple entries.  
- Addresses an issue that prevents VMs in an RD Pooled Desktop Collection from being recreated if the VMs are Gen2.  
- ​ Addresses an issue that sometimes prevents users from starting Microsoft Outlook after logging on to a Remote Desktop session. ​  
- Addresses an unexpected logon termination issue with a third-party Remote Desktop Service (RDS) application.  

To fix these issues, install [August 30, 2018 Windows Cumulative Update](https://support.microsoft.com/help/4343884).  

July 2018  

- Addresses an issue that makes Microsoft Outlook unresponsive during remote sessions if the system stays locked after the removal of a smart card. ​  
To fix this issue, install [July 24, 2018 Windows Cumulative Update](https://support.microsoft.com/help/4338822).  

June 2018  

- Addresses an issue when TS Gateway service crashes in aaedge.dll due to NULL deref.  
- ​ Addresses a system crash (Stop 3B) in win32kfull.sys when canceling journal hook operations or disconnecting a remote session. ​  
- Addresses an issue in a Remote Desktop VDI deployment that prevents a mounted UPD from disconnecting, which results in the creation of temp files.  
- ​ Addresses an issue that causes a connection failure when a Remote Desktop connection doesn't read the bypass list for a proxy that has multiple entries.  
- Addresses an issue that prevents VMs in an RD Pooled Desktop Collection from being recreated if the VMs are Gen2.  
- ​ Addresses an issue that sometimes prevents users from starting Microsoft Outlook after logging on to a Remote Desktop session. ​  
- Addresses an unexpected logon termination issue with a third-party Remote Desktop Service (RDS) application.  

To fix these issues, install [June 21, 2018 Windows Cumulative Update](https://support.microsoft.com/help/4284833).  

May 2018  

- Addresses an issue that can cause excessive memory usage when using smart cards on a Windows Terminal Server system. ​​  
- Addresses an issue when Shell notification thread in rdpinit exits and remoteapp doesn't receive the change notifications  
- Addresses an issue when MSRA is missing previously existing option to specify sessionID  
- ​​ Addresses an issue that may cause an error when connecting to a Remote Desktop server. For more information, see CredSSP updates for CVE-2018-0886.  

To fix these issues, install [May 17, 2018 Windows Cumulative Update](https://support.microsoft.com/help/4103720).  

April 2018  

- Addresses an issue in Windows Multipoint Server 2016 that may generate the error "The MultiPoint service isn't responding on this machine. To fix the issue, try restarting the machine."  
- Addresses an issue that prevents User Profile Disks (UPDs) from loading. This loading failure generates the error "We can't sign into your account", and users receive a temporary profile.  
- Addresses an issue that causes the high contrast theme setting to be applied incorrectly when a user logs in using RDP.  
- The Remote Desktop Client (RDP) update will enhance the error message that is presented when an updated client fails to connect to a server that hasn't been updated.  

To fix these issues, install [April 17, 2018 Windows Cumulative Update](https://support.microsoft.com/help/4093120).  

March 2018  

- Addressed an issue where Remote Desktop License report is corrupted when it reaches greater than 4 Kb size limit.  
- Addresses a race condition in RemoteApp that occurs when an opened RemoteApp window opens behind the previous foreground window.  
- Addresses issue with system performance that causes logons to become unresponsive with the message "Please wait for the Remote Desktop Configuration" because of a deadlock in the WinRM service.  

To fix these issues, install [March 22, 2018, Windows Cumulative Update](https://support.microsoft.com/help/4088889).  
  
February 2018  

- Addresses issue where logons to a Remote Desktop VDI collection start to fail after a period of server uptime. The Performance Counter Remote Desktop Connection Broker Redirector Counterset/RPC Contexts will show incremental growth during logon hours. When the value reaches 40, new connections to the farm fail or time out.  
- Addresses an issue where Japanese keyboard layout wasn't functioning properly during Remote Assistance session  
- Addresses an issue where the language bar disappears after closing MSRA connection  
- Addresses issue where logons to a Remote Desktop VDI Farm fail after the connection broker loses access to the SQL Database for more than two minutes. This causes virtual machines from collections to go to an Unknown state. The Administrator must restart the Remote Desktop Connection Broker service to recover from the failure.
- Addresses an issue where users can see a black screen instead of the desktop when Intel Graphics is used for acceleration in RDP sharing in Citrix.  
- Addresses issue where some Remote Desktop Protocol (RDP) clients that used an absolute URI (instead of a relative URI) were blocked by the Web Application Proxy (WAP) server from connecting to the Remote Desktop Gateway. This affected RDP clients on iOS, Mac, Android, and the Windows modern RDP client app. The error is "We couldn't connect to the gateway because of an error. If this keeps occurring, ask your admin or tech support for help. Error code: 0x03000008."  

To fix these issues, install [February 22, 2018, Windows Cumulative Update](https://support.microsoft.com/help/4077525).  

January 2018  

- Addressed an issue where RDP USB CD/DVD drive redirection fails with error "This device cannot start. (Code 10). STATUS_DEVICE_POWER_FAILURE." .  

To fix these issues, install [January 17, 2018, Windows Cumulative Update](https://support.microsoft.com/help/4057142).  

December 2017  

- None.  

November 2017  

- Addressed a token leak issue in the **services.exe** file that occurs after you apply update [3175024](https://support.microsoft.com/help/3175024/ms16-111-description-of-the-security-update-for-windows-kernel-septemb). This results in a kernel session object leak that degrades system performance over time. This especially affects Terminal Server implementations in which more user logons typically occur.  
- Addressed an issue where Remote Desktop clipboard redirection policy doesn't take effect if reconnecting to an existing session and policy has changed between the initial connect and the session reconnect.  

To fix these issues, install [November 27, 2017, Windows Cumulative Update](https://support.microsoft.com/help/4051033).  

October 2017  

- Addressed an issue in which the language bar stays open after closing a RemoteApp application, which prevents sessions from being disconnected.  
- Addressed an issue in which the working directory of RemoteApps on Server 2016 is set to %windir%\System32 regardless of the application's directory.  

To fix these issues, install [October 10, 2017, Windows Cumulative Update](https://support.microsoft.com/help/4041691).  

September 2017  

- Addressed an issue in which the Remote Desktop's idle timeout warning doesn't appear after the idle time elapses.  
- Addressed RemoteApp display issues that occur when you minimize and restore a RemoteApp to full-screen mode.  
- Addressed an issue in which redirecting multiple RemoteFX USB devices causes a Stop error to occur.  
- Addressed an issue in which console and RDP logons permanently stop responding at "Applying user profile settings" because of a deadlock between DPAPI/LSASS and RDR. After the deadlock occurs, new logons fail until the logon computer is restarted.  
- Addressed an issue in which using a smart card to log on to a Remote Desktop Server sometimes causes the server to stop responding.  

To fix these issues, install [September 28, 2017, Windows Cumulative Update](https://support.microsoft.com/help/4038801).  

August 2017  

- Addressed an issue in Windows 10 version 1607 in which a Remote Desktop client that's trying to connect through an RD gateway can't connect or disconnects intermittently. 
- Addressed an issue in which a black screen appears when starting an application on Citrix XenApp that was deployed from Windows Server 2016. For more information, see [CTX225819](https://support.citrix.com/article/CTX225819).  

To fix these issues, install [August 16, 2017, Windows Cumulative Update](https://support.microsoft.com/help/4034661).  

July 2017

- Addressed an issue in which the RDP client leaks a USER handle for every Audio redirection. 
- Addressed an issue where Windows Multipoint Server (WMS) 2016 doesn't allow configuring of per-device licensing.  
- Addressed an issue in Windows Multipoint Server 2012 where DisplayToast() fails when using a custom shell.  
- Addressed an issue in which File Explorer doesn't refresh automatically when using RemoteApps on Windows Server 2016.  
- Addressed an issue in which a Remote Desktop connection through Windows 2016 RDS server fails authentication when using smartcards.  

To fix these issues, install [July 18, 2017 Windows Cumulative Update](https://support.microsoft.com/help/4025334).  

June 2017

- Addressed an issue in which a 2012 R2 (or earlier version) Remote Desktop License Server causes the 2016 Remote Desktop Services Host to crash and stop giving sessions to clients.  
- Addressed an issue in which Mstsc.exe is missing the **OK** and **Cancel** buttons from Local Devices and Resources in the Norwegian Language Pack.  

To resolve these issues, install [June 27, 2017 Windows Cumulative Update](https://support.microsoft.com/help/4022723).  

May 2017

- Addressed an issue in which MultiPoint isn't supporting Windows 10 resolutions.  
- Addressed an issue that causes a device to crash every time that a user logs off from a remote session by using a Virtual Desktop Agent (VDA).  
To resolve these issues, install [May 9, 2017, Windows Cumulative Update](https://support.microsoft.com/help/4019472).  

April 2017

- Addressed an issue that was causing connections (after the first connection request) from a Remote Desktop Client to a Remote Desktop session to fail after upgrading from Windows 10 version 1511 to Windows 10 version 1607.  

To resolve this issue, install [April 11, 2017, Windows Cumulative Update](https://support.microsoft.com/help/4015217).  

March 2017

- Addressed an issue in which RD Virtualization Host role fails to install on nested VMs.  
- Addressed an issue in which Remote Desktop Servers crash with aStop 0x27in RxSelectAndSwitchPagingFileObject when RDP clients connect and utilize redirected drives, printers, or removable USB drives.  

To resolve these issues, install [March 14, 2017, Windows Cumulative Update](https://support.microsoft.com/help/4013429).  

January 2017

- Addressed an issue in which landscape print jobs that are submitted over RDP printer redirection are clipped in v4 print drivers.  
To resolve this issue, install [January 26, 2017, Windows Cumulative Update](https://support.microsoft.com/help/4011347).  

December 2016

- Addressed an issue in which the Request Control function doesn't work with Remote Assistance if the user who is being assisted is on Windows Server 2008 R2 or Windows Server 2012.  
- Addressed an issue in which users can't connect to a Remote Desktop server due to a deadlock in the connection termination sequence (black screen).  

To resolve this issue, install [January 10, 2017, Windows Cumulative Update](https://support.microsoft.com/help/4009938).  

November 2016

- Addressed an issue in which sometimes, the user isn't able to see a RemoteApp window on the client, even though the window appears on the server.  
- Addressed an inability to log on to an RDP server after some time (days) remotely or from console.  
- Addressed an issue in which a rare race condition causes MultiPoint servers to become unresponsive after startup. Users can' t log in to any station.  

To resolve this issue, install [November 8, 2016 Windows Cumulative Update](https://support.microsoft.com/help/4001885).  

October 2016  

- Addressed a connectivity issue from a 32-bit application to a Remote Desktop Gateway that doesn't have HTTP tunneling enabled.  
To resolve this issue, install [October 27, 2016, Windows Cumulative Update](https://support.microsoft.com/help/4001753).  

September 2016

- Addressed an issue in which the user profile disk (UPD) doesn't get unmounted when the user logs off.

To resolve this issue, install [September 29, 2016, Windows Cumulative Update](https://support.microsoft.com/help/4001755).  

## Component area  

General OS updates  

- [KB4093120](https://support.microsoft.com/help/4093120) Addresses an issue that causes the high contrast theme setting to be applied incorrectly when a user logs in using RDP.  
- [KB4093120](https://support.microsoft.com/help/4093120) Addresses an issue that prevents User Profile Disks (UPDs) from loading. This loading failure generates the error "We can't sign into your account", and users receive a temporary profile.  
- [KB4103720](https://support.microsoft.com/help/4103720) Addresses an issue that may cause an error when connecting to a Remote Desktop server. For more information, see CredSSP updates for CVE-2018-0886.  
- [KB4103720](https://support.microsoft.com/help/4103720) Addresses an issue that can cause excessive memory usage when using smart cards on a Windows Terminal Server system.  
- [KB4284833](https://support.microsoft.com/help/4284833) Addresses an issue that prevents VMs in an RD Pooled Desktop Collection from being recreated if the VMs are Gen2.  
- [KB4284833](https://support.microsoft.com/help/4284833) Addresses an issue that sometimes prevents users from starting Microsoft Outlook after logging on to a Remote Desktop session.  
- [KB4284833](https://support.microsoft.com/help/4284833) Addresses an unexpected logon termination issue with a third-party Remote Desktop Service (RDS) application  
- [KB4284833](https://support.microsoft.com/help/4284833) Addresses an issue in a Remote Desktop VDI deployment that prevents a mounted UPD from disconnecting, which results in the creation of temp files.  
- [KB4284833](https://support.microsoft.com/help/4284833) Addresses a system crash (Stop 3B) in win32kfull.sys when cancelling journal hook operations or disconnecting a remote session.  
- [KB4338822](https://support.microsoft.com/help/4338822) Addresses an issue that makes Microsoft Outlook unresponsive during remote sessions if the system stays locked after the removal of a smart card.  
- [KB4343884](https://support.microsoft.com/help/4343884) Addresses an issue that causes svchost.exe to stop working intermittently. This issue occurs when the SessionEnv service is running, which causes a partial load of the user's configuration during a Remote Desktop session.  
- [KB4343884](https://support.microsoft.com/help/4343884) Addresses an issue when RDP fails due to server exceeding connection limit  
- [KB4457127](https://support.microsoft.com/help/4457127) Makes the visibility Group Policy for the Settings Page available under User Configuration and Computer Configuration.  
- [KB4457127](https://support.microsoft.com/help/4457127) Addresses an issue that causes a Remote Desktop Session Host server to occasionally stop responding during login.  
- [KB4457127](https://support.microsoft.com/help/4457127) Addresses an issue that causes login to fail when using a smart card to log in to a Remote Desktop Server. The error is "STATUS_LOGON_FAILURE".  
- [KB4088889](https://support.microsoft.com/help/4088889) Addresses issue with system performance that causes logons to become unresponsive with the message "Please wait for the Remote Desktop Configuration" because of a deadlock in the WinRM service.  
- [KB4077525](https://support.microsoft.com/help/4077525) Addresses an issue where users can see a black screen instead of the desktop when Intel Graphics is used for acceleration in RDP sharing in Citrix (**general os**).
- [KB4051033](https://support.microsoft.com/help/4051033) Addressed a token leak in **services.exe** that occurs after you apply update [3175024](https://support.microsoft.com/help/3175024). This results in a kernel session object leak that degrades system performance over time. This especially affects Terminal Server implementations, where more user logons typically occur
- [KB4038801](https://support.microsoft.com/help/4038801) Addressed an issue in which console and RDP logons permanently stop responding at "Applying user profile settings" because of a deadlock between DPAPI/LSASS and RDR. After the deadlock occurs, new logons fail until the logon computer is restarted.
- [KB4038801](https://support.microsoft.com/help/4038801) Addressed an issue in which the Remote Desktop's idle time-out warning doesn't appear after the idle time elapses.  
- [KB4034661](https://support.microsoft.com/help/4034661) Addressed an issue in which a black screen appears when launching an application on Citrix XenApp that was deployed from Windows Server 2016. For more details, see [CTX225819](https://support.citrix.com/article/CTX225819).  
- [KB4025334](https://support.microsoft.com/help/4034661) Addressed an issue in which a remote desktop connection with Windows 2016 RDS server fails authentication when using smartcards.  
- [KB4019472](https://support.microsoft.com/help/4019472) Addressed an issue that causes a device to crash every time that a user logs off from a remote session by using a Virtual Desktop Agent (VDA).  
- [KB4013429](https://support.microsoft.com/help/4013429) Addressed an issue in which Remote Desktop Servers crash with aStop 0x27in RxSelectAndSwitchPagingFileObject when RDP clients connect and utilize redirected drives, printers, or removable USB drives.  
- [KB4009938](https://support.microsoft.com/help/4009938) Addressed an issue in which u sers cannot connect to Remote Desktop server due to deadlock in connection termination sequence (black screen).  
- [KB4001885](https://support.microsoft.com/help/4001885) Addressed an inability to  log on to an RDP server after some time (days) remotely or from console.  

Device Redirection & Printing  

- [KB4057142](https://support.microsoft.com/help/4057142) Addressed an issue where RDP USB CD/DVD drive redirection fails with error "This device cannot start. (Code 10).  STATUS_DEVICE_POWER_FAILURE."
- [KB4038801](https://support.microsoft.com/help/4038801) Addressed an issue in which redirecting multiple RemoteFX USB devices causes a Stop error.  
- [KB4038801](https://support.microsoft.com/help/4038801) Addressed an issue in which using a smart card to log on to a Remote Desktop Server sometimes causes the server to stop responding.
- [KB4011347](https://support.microsoft.com/help/4011347) Addressed an issue in which l andscape print jobs submitted over RDP printer redirection are clipped in v4 print drivers.  

Licensing  

- [KB4457127](https://support.microsoft.com/help/4457127) Addresses an issue that displays the report date as "Unknown" in the Remote Desktop License Manager.
- [KB4088889](https://support.microsoft.com/help/4088889) Addressed an issue where Remote Desktop License report is corrupted when it reaches greater than 4Kb size limit.
- [KB4022723](https://support.microsoft.com/help/4022723) Addressed an issue in which a 2012 R2 (or earlier version) Remote Desktop License Server causes the 2016 Remote Desktop Services Host to crash and stop giving sessions to clients.  

MultiPoint Services  

- [KB4093120](https://support.microsoft.com/help/4093120) Addresses an issue in Windows Multipoint Server 2016 that may generate the error "The MultiPoint service is not responding on this machine. To fix the issue try restarting the machine."  
- [KB4025334](https://support.microsoft.com/help/4025334) Addressed an issue in which Windows Multipoint Server (WMS) 2016 doesn't allow you to configure per device licensing.  
- [KB4025334](https://support.microsoft.com/help/4025334) Addressed an issue in Windows Multipoint Server 2016 where DisplayToast () fails when using a custom shell.  
- [KB4019472](https://support.microsoft.com/help/4019472) Addressed an issue in which MultiPoint is not supporting Windows 10 resolutions.  
- [KB4001885](https://support.microsoft.com/help/4001885) Addressed an issue in which A rare race condition causes MultiPoint servers to become unresponsive after startup. Users can't log in to any stations.  

RemoteApp  

- [KB4103720](https://support.microsoft.com/help/4103720) Addresses an issue when Shell notification thread in rdpinit exits and remoteapp does not receive the change notifications.  
- [KB4088889](https://support.microsoft.com/help/4088889) Addresses a race condition in RemoteApp that occurs when an activated RemoteApp window opens behind the previous foreground window.
- [KB4041688](https://support.microsoft.com/help/4041688) Addressed an issue in which the language bar stays open after closing a RemoteApp application, which prevents sessions from being disconnected.
- [KB4041688](https://support.microsoft.com/help/4041688) Addressed an issue in which the working directory of RemoteApps on Server 2016 is set to %windir%\System32 regardless of the application's directory.
- [KB4038801](https://support.microsoft.com/help/4038801) Addressed RemoteApp display issues that occur when you minimize and restore a RemoteApp to full-screen mode.  
- [KB4025334](https://support.microsoft.com/help/4025334) Addressed an issue in which File Explorer doesn't refresh automatically when using RemoteApps on Windows Server 2016.  
- [KB4001885](https://support.microsoft.com/help/4001885) Addressed an issue in which s ometimes the user is unable to see a RemoteApp window on the client, even though it appears on the server.  

Remote Assistance  

- [KB4103720](https://support.microsoft.com/help/4103720) Addresses an issue when MSRA is missing previously existing option to specify sessionID.  
- [KB4077525](https://support.microsoft.com/help/4077525) Addresses an issue where the Japanese keyboard layout was not functioning properly during Remote Assistance session.  
- [KB4077525](https://support.microsoft.com/help/4077525) Addresses an issue where the language bar disappears after closing MSRA connection.  
- [KB4009938](https://support.microsoft.com/help/4009938) Addressed an issue in which the Request Control function doesn't work with Remote Assistance if the user being assisted is on Windows Server 2008 R2 or Windows Server 2012.  

Remote Desktop Client (Mstsc.exe)  

- [KB4093120](https://support.microsoft.com/help/4093120) The Remote Desktop Client (RDP) update will enhance the error message that is presented when an updated client fails to connect to a server that has not been updated.  
- [KB4103720](https://support.microsoft.com/help/4103720) Addresses an issue that may cause an error when connecting to a Remote Desktop server. For more information, see CredSSP updates for CVE-2018-0886.  
- [KB4284833](https://support.microsoft.com/help/4284833) Addresses an issue that causes a connection failure when a Remote Desktop connection doesn't read the bypass list for a proxy that has multiple entries.  
- [KB4034661](https://support.microsoft.com/help/4034661) Addressed an issue in Windows 10 1607 where a Remote Desktop client that is trying to connect via an RD gateway can't connect or disconnects intermittently.  
- [KB4025334](https://support.microsoft.com/help/4025334) Addressed an issue in which a n RDP client leaks a USER handle for every Audio redirection.  
- [KB4022723](https://support.microsoft.com/help/4022723) Addressed an issue in which Mstsc.exe is missing the **OK**  and **Cancel** buttons from Local Devices and Resources in Norwegian Language Pack.  
- [KB4015217](https://support.microsoft.com/help/4015217) Addressed an issue that was causing connections (after the first connection request) from a Remote Desktop Client to a Remote Desktop session to fail after upgrading from Windows 10 version 1511 to Windows 10, version 1607.  
- [KB4001753](https://support.microsoft.com/help/4001753) Addressed a connectivity issue from a 32-bit application to a Remote Desktop Gateway that doesn't have HTTP tunneling enabled.  

Remote Desktop Connection Broker  

- [KB4077525](https://support.microsoft.com/help/4077525) Addresses issue where logons to a Remote Desktop VDI collection start to fail after a period of server uptime. The Performance Counter Remote Desktop Connection Broker Redirector Counterset/RPC Contexts will show incremental growth during logon hours. When the value reaches 40, new connections to the farm fail or time out.  
- [KB4077525](https://support.microsoft.com/help/4077525) Addresses issue where logons to a Remote Desktop VDI Farm fails after the connection broker loses access to the SQL Database for more than two minutes. This causes virtual machines from collections to go to an Unknown state. The Administrator must restart the Remote Desktop Connection Broker service to recover from the failure..  

Remote Desktop Gateway  

- [KB4284833](https://support.microsoft.com/help/4284833) Addresses an issue when Remote Desktop Gateway service crashes in aaedge.dll due to NULL deref.
- [KB4343884](https://support.microsoft.com/help/4343884) Addresses an issue that causes users to disconnect from a remote session when the Remote Desktop Gateway service stops working.
- [KB4077525](https://support.microsoft.com/help/4077525) Addresses issue where some Remote Desktop Protocol (RDP) clients that used an absolute URI (instead of a relative URI) were blocked by the Web Application Proxy (WAP) server from connecting to the Remote Desktop Gateway. This affected RDP clients on iOS, Mac, Android, and the Windows modern RDP client app. The error is "We couldn't connect to the gateway because of an error. If this keeps occurring, ask your admin or tech support for help. Error code: 0x03000008."  

> [!Note]
> Also see "Remote Desktop Client (Mstsc.exe)" above as some Remote Desktop Gateway issues were identified on the client side.  

Remote Desktop Virtualization Host  

- [KB4013429](https://support.microsoft.com/help/4013429) Addressed an issue in which t he RD Virtualization Host role fails to install on nested VM.  

Remote Desktop Web Access  

- None.

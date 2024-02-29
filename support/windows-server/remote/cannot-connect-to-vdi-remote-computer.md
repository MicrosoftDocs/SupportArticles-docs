---
title: Remote Desktop can't connect to VDI-based computer
description: Fixes an issue where Remote Desktop can't connect to a VDI-based remote computer.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:performance-audio-and-video-and-remotefx, csstroubleshoot
---
# Remote Desktop cannot connect to the VDI-based remote computer after enabling Microsoft RemoteFX 3D Video Adapter

This article provides a solution to an issue where Remote Desktop can't connect to a Virtual Desktop Infrastructure (VDI)-based remote computer.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2820155

## Symptoms

After installing the RemoteFX 3D Video Adapter on a VDI-based physical machine or a virtual machine that is hosted on a Hyper-V server, when you try to connect to the machine using Remote Desktop connection, it may fail. Additionally, you may receive the error message that is similar to the following:

> Remote Desktop can't connect to the remote computer for one of these reasons:
>
> 1. Remote access to the server is not enabled
> 2. The remote computer is turned off
> 3. The remote computer is not available on the network
>
> Make sure the remote computer is turned on and connected to the network, and that remote access is enabled.

You may also receive the following error in the Windows Event Log:

> Log Name: Microsoft-Windows-TerminalServices-LocalSessionManager/Operational  
Source:       Microsoft-Windows-TerminalServices-LocalSessionManager  
Date:          \<Date>\<Time>  
Event ID:    17  
Level:         Error  
User:          SYSTEM  
Computer: machinename.domain.com  
Description:  
Remote Desktop Service start failed. The relevant status code was 0x800706b5.  

> [!NOTE]
> You can connect to the computer using RDP if you remove the RemoteFX 3D Video Adapter from the VM.

## Cause

With the release of Service Pack 1 for Windows 7 and Windows Server 2008 R2, a new Windows Firewall rule is added for RemoteFX. This problem occurs if RemoteFX Windows Firewall rule is not enabled.

For more information on Microsoft RemoteFX, visit the following Microsoft Web site:

[Microsoft RemoteFX](https://technet.microsoft.com/library/ff817578%28v=ws.10%29.aspx)

## Resolution

To resolve the problem, you must enable the RemoteFX Windows Firewall rule manually.

To enable the RemoteFX rule by using Windows Firewall with Advanced Security

1. Click the **Start** button, and then click **Control Panel**.
2. In the **Control Panel** windows click **Windows Firewall**.
3. In the left pane, click **Allow a program or feature through Windows Firewall**.
4. Click **Change settings**. If you're prompted for an administrator password or confirmation, type the password or provide confirmation.
5. Under **Allowed programs and features**, select the check box next to **Remote Desktop - RemoteFX**, and then use the check boxes in the columns to select the network location types you want to allow communication on.
6. Click **OK**.

Alternatively, if you enable Remote Desktop by using the System properties window, the rule is enabled automatically.

1. Click the **Start** button, and then click **Control Panel**.
2. Click on **System** icon.
3. Under Control Panel Home, click **Remote settings**.
4. Click the **Remote** tab. Under **Remote Desktop**, Select **Don't allow connections to this computer** and the click **Apply**.  
5. Now select either option depending on your security requirements:
   - **Allow connections from computers running any version of Remote Desktop (less secure)**
   - **Allow connections only from computers running Remote Desktop with Network Level Authentication (more secure)**  

6. Click on **Apply** and then **OK**.

## More information

You must enable the RemoteFX Windows Firewall rule manually if you enable Remote Desktop of VDI machine using either of the methods:

1. Using WMI command:  

    ```console
     wmic rdtoggle where (AllowTSConnections=0) call SetAllowTSConnections 1  
    ```

2. Toggling the registry:  
     `REG.exe ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0`  
3. Enabling firewall exceptions for Remote desktop using `netsh`  command or Windows Firewall APIs:  

    ```console
     netsh advfirewall firewall set rule group="remote desktop" new enable=Yes  
    ```

4. Using PowerShell script provided on [Microsoft TechNet Script Center](https://go.microsoft.com/fwlink/?linkid=184804) to configure VDI desktops.
5. Upgrading to Windows 7 with SP1 on a virtual desktop that already had Remote Desktop enabled.

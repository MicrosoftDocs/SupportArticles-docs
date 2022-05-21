---
title: Guidance for troubleshooting RDS session connectivity
description: Introduces general guidance for troubleshooting scenarios related to RDS session connectivity.
ms.date: 03/16/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
ms.technology: windows-server-rds
---
# RDS session connectivity troubleshooting guidance

This article is designed to help you troubleshoot Remote Desktop Session (RDS) connectivity scenarios.

## Check the status of the RDP protocol

- [Check the status of the RDP protocol on a remote computer](/windows-server/remote/remote-desktop-services/troubleshoot/rdp-error-general-troubleshooting#check-the-status-of-the-rdp-protocol-on-a-remote-computer)
- [Check whether a Group Policy Object (GPO) is blocking RDP on a local computer](/windows-server/remote/remote-desktop-services/troubleshoot/rdp-error-general-troubleshooting#check-whether-a-group-policy-object-gpo-is-blocking-rdp-on-a-local-computer)
- [Check whether a GPO is blocking RDP on a remote computer](/windows-server/remote/remote-desktop-services/troubleshoot/rdp-error-general-troubleshooting#check-whether-a-gpo-is-blocking-rdp-on-a-remote-computer)
- [Modifying a blocking GPO](/windows-server/remote/remote-desktop-services/troubleshoot/rdp-error-general-troubleshooting#modifying-a-blocking-gpo)
- [Check the status of the RDP services](/windows-server/remote/remote-desktop-services/troubleshoot/rdp-error-general-troubleshooting#check-the-status-of-the-rdp-services)

## Check whether the RDP listener is working

- [Check the status of the RDP listener](/windows-server/remote/remote-desktop-services/troubleshoot/rdp-error-general-troubleshooting#check-the-status-of-the-rdp-listener)
- [Check the status of the RDP self-signed certificate](/windows-server/remote/remote-desktop-services/troubleshoot/rdp-error-general-troubleshooting#check-the-status-of-the-rdp-self-signed-certificate)
- [Check the permissions of the MachineKeys folder](/windows-server/remote/remote-desktop-services/troubleshoot/rdp-error-general-troubleshooting#check-the-permissions-of-the-machinekeys-folder)
- [Check the RDP listener port](/windows-server/remote/remote-desktop-services/troubleshoot/rdp-error-general-troubleshooting#check-the-rdp-listener-port)
- [Check that another application isn't trying to use the same port](/windows-server/remote/remote-desktop-services/troubleshoot/rdp-error-general-troubleshooting#check-that-another-application-isnt-trying-to-use-the-same-port)
- [Check whether a firewall is blocking the RDP port](/windows-server/remote/remote-desktop-services/troubleshoot/rdp-error-general-troubleshooting#check-whether-a-firewall-is-blocking-the-rdp-port)

## Common issues and solutions

### Credential limit per app

Windows allows only up to 20 credentials per app. If you have to have more than 20 credentials per app, follow these steps to bypass the 20-credential limit:

1. Run *regedit*.
2. Create or set the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Vault\MaxPerAppCredentialNumber` DWORD-type registry value to a number that's greater than 20.
3. Restart the computer.
4. Test the settings by creating a new set of credentials in the Remote Desktop client.

Potential risks: When you change this registry setting, it's important to keep the following things in mind:

- This is an admin operation. Any errors that are introduced into the registry could cause your computer to become unstable. Non-admin users change the registry entries at their own risk.
- This registry change will affect all apps that are installed on the computer.  

### Clients can't connect, and "Class not registered" error returned

When you try to connect to a remote computer by using a client that's running Windows 10, version 1709 or a later version, the client might not connect if the Remote Desktop Session Host server displays the "Class not registered (0x80040154)" error code.

This issue occurs if the user who's trying to connect has a mandatory user profile. To resolve this issue, install the [July 24, 2018—KB4338817 (OS Build 16299.579)](https://support.microsoft.com/help/4338817/windows-10-update-kb4338817) Windows update.

### Remote laptop disconnects from wireless network

This issue might occur when a Remote Desktop client connects to a laptop computer by using an 802.1x wireless network. The laptop intermittently disconnects from the wireless network and doesn't automatically reconnect.

This is a known issue that occurs if the network authentication setting for the wireless network connection is **User authentication**.

To work around this issue, set the network authentication setting to **User or computer authentication** or **Computer authentication**.

> [!Note]
> To change the network authentication settings on a single computer, you might have to use the Network and Sharing Center control panel to create a new wireless connection that uses the new settings.

For a full description of how to configure wireless network settings by using GPOs, see [Configure Wireless Network (IEEE 802.11) Policies](/windows-server/networking/core-network-guide/cncg/wireless/e-wireless-access-deployment#bkmk_policies).

## Data collection

Before contacting Microsoft support, you can gather information about your issue.

### Prerequisites

1. TSSv2 must be run by accounts with administrator privileges on the local system, and EULA must be accepted (once EULA is accepted, TSSv2 won't prompt again).
2. We recommend the local machine `RemoteSigned` PowerShell execution policy.

> [!NOTE]
> If the current PowerShell execution policy doesn't allow running TSSv2, take the following actions:
>
> - Set the `RemoteSigned` execution policy for the process level by running the cmdlet `PS C:\> Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned`.
> - To verify if the change takes effect, run the cmdlet `PS C:\> Get-ExecutionPolicy -List`.
> - Because the process level permissions only apply to the current PowerShell session, once the given PowerShell window in which TSSv2 runs is closed, the assigned permission for the process level will also go back to the previously configured state.

### Gather key information before contacting Microsoft support

1. Download [TSSv2](https://aka.ms/getTSSv2) on all nodes and unzip it in the *C:\\tss_tool* folder.
2. Open the *C:\\tss_tool* folder from an elevated PowerShell command prompt.
3. Start the traces on the client and the server by using the following cmdlets:
    > [!NOTE]
    > Run these traces simultaneously on the client, Session Host server(s) and licensing server(s).

    - Client:  

        ```powershell
        TSSv2.ps1 -scenario Net_RDScli
        ```

    - Server(s):  

        ```powershell
        TSSv2.ps1 -scenario Net_RDSsrv
        ```

    If you get many security warnings related to the execution policy while running the script, run the `Set-ExecutionPolicy -ExecutionPolicy Bypass -force -Scope Process` cmdlet to bypass those warnings.
4. Respond to the EULA prompt.
5. Allow recording (Video), and enter *Y*.
6. When the script displays `Reproduce the issue and enter 'Y' key AFTER finishing the repro` on both the client and the server(s), start reproducing the issue.
7. Enter *Y* to finish the log collection after the issue is reproduced.

The traces will be stored in a zip file in the *C:\\MSDATA* folder, which can be uploaded to the Microsoft workspace for analysis.

## Reference

- [Clients can't connect and see "No licenses available" error](cannot-connect-rds-no-license-server.md)
- ["Remote Desktop Service is currently busy" error when connecting](/windows-server/remote/remote-desktop-services/troubleshoot/remote-desktop-service-currently-busy)
- [Remote Desktop client disconnects and can't reconnect to the same session](/windows-server/remote/remote-desktop-services/troubleshoot/rdp-client-disconnects-cannot-reconnect-same-session)
- [Poor performance or application problems during remote desktop connection](/windows-server/remote/remote-desktop-services/troubleshoot/poor-performance-or-application-problems)
- [User can't authenticate or must authenticate twice](/windows-server/remote/remote-desktop-services/troubleshoot/cannot-authenticate-or-must-authenticate-twice)

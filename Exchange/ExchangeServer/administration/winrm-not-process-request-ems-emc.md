---
title: WinRM can't determine content type of HTTP response
description: Provides resolutions to resolve the error (The WinRM client... cannot determine the content type of the HTTP response from the destination computer) when you try to start Exchange Management Shell/Console.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Issues connecting to Exchange Management Shell
  - Exchange Server
  - CI 119623
  - CSSTroubleshoot
ms.reviewer: benwinz, v-six
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010
ms.date: 01/24/2024
---
# Error (The WinRM client... cannot determine the content type of the HTTP response from the destination computer) when you try to start Exchange Management Shell/Console

_Original KB number:_ &nbsp; 2028305

## Symptoms

When you try to start Exchange Management Shell (EMS) or Exchange Management Console (EMC) on a computer that is running Exchange Server 2010, you receive the following error message:

> Connecting to remote server failed with the following error message: The WinRM client cannot process the request. It cannot determine the content type of the HTTP response from the destination computer. The content type is absent or invalid. For more information, see the about_Remote_Troubleshooting Help topic.

## Cause

This problem occurs because one or more of the following conditions are true:

- The Kerbauth module is configured incorrectly in Internet Information Services (IIS) in one of the following ways:
  - The Kerbauth module is displayed as a Managed module instead of as a Native module.
  - The Kerbauth module has been loaded on the Default website level (instead of, or in addition to, the PowerShell virtual directory).
- The user does not have **Remote PowerShell Enabled** status.
- The WSMan module entry is missing from the Global modules section of the ApplicationHost.config file that is in the following location:  
    `C:\Windows\System32\Inetsrv\config\ApplicationHost.config`

This causes the WSMan module to be displayed as a Managed module in the PowerShell virtual directory.

> [!NOTE]
> The WSMan Module entry may also be missing from the ApplicationHost.config file if the WinRM IIS Extension feature is installed on the server.

## Resolution

To resolve this problem, use one of the following methods:

- Make sure that the Kerbauth module is not enabled on the default website but is, instead, enabled only for the PowerShell virtual directory. Remote PowerShell uses Kerberos authentication for the user connection. Internet Information Services (IIS) implements this Kerberos authentication method by using a Native module.

    In IIS Manager, Kerbauth should be listed as a Native module in the PowerShell virtual directory. The DLL location for this module should point to `C:\Program Files\Microsoft\Exchange Server\v14\Bin\kerbauth.dll`.

    > [!NOTE]
    > The Local entry type for the Kerbauth module indicates that the module was enabled directly on this level and was not inherited from a parent level.

- Make sure that the user who is trying to connect has a **Remote PowerShell Enabled**  status. To determine whether a user is enabled for Remote PowerShell, you have to start Exchange Management Shell by using an account that is enabled, and then run the following command:

    ```powershell
    (Get-User <username>).RemotePowershellEnabled
    ```

    This query returns a response of **True** or **False**. If the output is displayed as **False**, the user is not enabled for Remote PowerShell. To enable the user, run the following command:

    ```powershell
    Set-User <username> -RemotePowerShellEnabled $True
    ```

- Make sure that the WSMan module is registered but not enabled at the Server level. Also make sure that the WSMan module is enabled for the PowerShell virtual directory. Then, verify that the following WSMan module entry is included in the `<globalModules>` section of the `C:\Windows\System32\Inetsrv\config\ApplicationHost.config` file as follows:

    ```xml
    <globalModules>
        <add name="WSMan" image="C:\Windows\system32\wsmsvc.dll" />
    ```

    > [!NOTE]
    > You must follow these steps even if the WinRM IIS Extension feature has been removed. This is because the uninstall procedure does not automatically fix the ApplicationHost.config file.

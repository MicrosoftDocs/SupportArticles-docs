---
title: Exchange Management Shell/Console doesn't start
description: Provides resolutions to resolve the error (The connection to the specified remote host was refused) when you try to start Exchange Management Shell or Exchange Management Console.
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
  - Exchange Server 2016
  - Exchange Server 2013
  - Exchange Server 2010
ms.date: 01/24/2024
---
# Error (The connection to the specified remote host was refused) when you try to start Exchange Management Shell or Exchange Management Console

_Original KB number:_ &nbsp; 2027064

## Symptoms

When you try to start Exchange Management Shell (EMS) or Exchange Management Console (EMC) on a computer that is running Microsoft Exchange Server 2010, Microsoft Exchange Server 2013, or Microsoft Exchange Server 2016, you receive the following error message:

> The connection to the specified remote host was refused. Verify that the WS-Management service is running on the remote host and configured to listen for requests on the correct port and HTTP URL. For more information, see the about_Remote_Troubleshooting Help topic.

## Cause

This problem occurs because one or more of the following conditions are true:

- The MSExchangePowerShellAppPool application pool is experiencing problems or is not running.
- The user does not have **Remote PowerShell Enabled** status.
- Windows Remote Management (WinRM) is configured incorrectly on the server.

## Resolution

To resolve this problem, use one of the following methods:

- Make sure that the MSExchangePowerShellAppPool application pool is running. If the pool is running, try to recycle it. Then, check for errors or warnings in the event logs.

- Make sure that the user who is trying to connect has **Remote PowerShell Enabled** status. To determine whether a user is enabled for Remote PowerShell, start Exchange Management Shell by using an account that has been enabled, and then run the following query:

    ```powershell
    (Get-User <username>).RemotePowershellEnabled
    ```

    This query returns a response of **True** or **False**. If the response is **False**, the user is not enabled for Remote PowerShell. To enable the user, run the following command:

    ```powershell
    Set-User \<username> -RemotePowerShellEnabled $True
    ```

- Make sure that WinRM is configured correctly on the server. To do this, follow these steps:

    1. Run WinRM QuickConfig. To do this, click **Start**, type *WinRM QuickConfig* in the **Start Search** box, and then press ENTER.

    2. Make sure that both tests pass and that no actions are required. If any actions are required, click **Yes**  in the prompt window to allow the WinRM configuration changes to be made.

    3. Click Start, type *cmd* in the **Start Search** box, and then press ENTER. In the Command Prompt window, type *WinRM enumerate winrm/config/listener* at the command prompt, and then press ENTER.

    4. Make sure that a listener exists for the HTTP protocol on port 5985, and that the listener is listening on all addresses.

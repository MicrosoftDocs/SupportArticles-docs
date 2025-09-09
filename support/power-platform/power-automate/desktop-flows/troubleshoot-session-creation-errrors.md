---
title: Session creation error codes in unattended desktop flow runs
description: Solves error codes related to session creation during unattended desktop flow runs in Power Automate.
author: johndund 
ms.author: johndund 
ms.date: 07/11/2025
ms.reviewer: madiazor, guco, fredg, alarnaud
ms.custom: sap:Desktop flows\Unattended flow runtime errors
---
# Resolve session creation errors for an unattended desktop flow run

This article provides background and potential solutions for session creation errors that might occur during an unattended desktop flow run in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate

## Symptoms

Your [unattended desktop flow run](/power-automate/desktop-flows/run-unattended-desktop-flows) might fail with one of the following error codes:

- [SessionCreationErrorWithThirdPartyCredentialProvider](#sessioncreationerrorwiththirdpartycredentialprovider)
- [SessionCreationUserPromptedForCredentialsAfterConnection](#sessioncreationuserpromptedforcredentialsafterconnection)
- [SessionCreationError](#sessioncreationerror)

## Cause

When an unattended session is run, Power Automate attempts to create a Remote Desktop Protocol (RDP) connection on the target machine. If this session creation fails, you might receive one of the error codes.

## SessionCreationErrorWithThirdPartyCredentialProvider

This error code occurs because third-party software interferes with Power Automate's ability to create a session on the machine. Power Automate doesn't support some third-party credential providers, or might experience conflicts depending on their configuration.

### Resolution

To resolve the issue, contact your administrator to uninstall the credential provider that Power Automate doesn't support.

You can find the full list of credential providers (many of which are built-in) on your machine in the following registry key:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers`

Each subkey represents an installed credential provider. The following table lists the credential providers that Power Automate currently doesn't support. If you have any of the following subkeys, work with your system administrator to uninstall the corresponding software.

| Name | Subkey name |
| :------------------------ | ---------------- |
| SailPoint Technologies Desktop Password Reset | 0094A34B-0BF0-4789-8B2D-8339E469D756 |
| SIDCredentialProvider | 36ED98C6-02FF-47e8-B7FE-957A411CEA16 |
| CGWinLogon | BDA6DA5B-7E7E-482C-9B3E-67AFF0C838C0 |

## SessionCreationUserPromptedForCredentialsAfterConnection

This error code occurs when the machine prompts for credentials after the RDP connection is established. Power Automate expects credentials to be handled during the connection setup, so this unexpected prompt might cause the flow to fail.

### Resolution

The resolution steps depend on the machine's setup. Follow the instructions to determine the setup and apply the appropriate solution:

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

1. Open **Command Prompt** and run `dsregcmd /status`.

2. In the output under the **Device State** section, check the values for `AzureAdJoined` and `DomainJoined`.

   **If `AzureAdJoined: YES` and `DomainJoined: NO`:**

   1. Open **Registry Editor** by pressing Windows+<kbd>R</kbd>, typing `regedit`, and pressing <kbd>Enter</kbd>.

   2. Navigate to the following path:

      `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services`

   3. Check if the `Terminal Services` key contains a `fPromptForPassword` subkey:

      - If it exists and is set to **1**, contact your IT department to disable the "Always prompt for password upon connection" policy. After the policy is updated, force a policy refresh on the machine.
      - If `fPromptForPassword` doesn't exist, navigate to:

        `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp`

        Look for the `fPromptForPassword` DWORD. If it exists, set its value to **0**. If it doesn't exist, create it and set its value to **0**.

   **For other machine configurations:**

   1. Open **Registry Editor** by pressing Windows+<kbd>R</kbd>, typing `regedit`, and pressing <kbd>Enter</kbd>.

   2. Navigate to the following path:

      `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services`

   3. Check if the `Terminal Services` key contains the following values:

      - `fPromptForPassword` = **1**
      - `SecurityLayer` = **0**
      - `UserAuthentication` = **0**

      If all three values exist, contact your IT department to update one of these values:

      - Set `fPromptForPassword` to **0**, or
      - Set `SecurityLayer` to **1** or **2**, or
      - Set `UserAuthentication` to **1**.

      If one or more values are missing:

      - Choose one of the missing values based on your requirements.
      - Navigate to:

        `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp`

      - Update (or create if not present) the selected value:

         - Set `fPromptForPassword` to **0**, or
         - Set `SecurityLayer` to **1** or **2**, or
         - Set `UserAuthentication` to **1**.

3. Restart the machine after making registry changes.

## SessionCreationError

This error code occurs when a session creation fails for an unknown reason.

### Resolution

To solve the issue:

- Ensure that you can remote desktop to the machine from another machine on your network. If you're using Windows Server, you can try to remote desktop to "localhost" from the local machine itself when logged in as another account. If these actions fail, see [General Remote Desktop connection troubleshooting](../../../windows-server/remote/rdp-error-general-troubleshooting.md).
- If you have a legal notice enabled for login, work with your system administrator to try disabling it. To see if the legal notice is activated, open Registry Editor and go to `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`. If `legalnoticecaption` or `legalnoticetext` isn't empty, work with your system administrator to disable the legal notice.
- Ensure that no third-party software is installed that might affect login or interfere with creating a remote desktop connection.
- If you use a domain account (DOMAIN\user) to connect, connectivity issues with the domain controller might prevent the session from opening correctly. Work with your system administrator to examine connectivity logs. If you're on a Microsoft Entra joined or Entra hybrid joined device, try using a UPN (`user@domain.com`). To see if you can use a UPN, go to **Start** > **Run**, and run the [dsregcmd /status](/entra/identity/devices/troubleshoot-device-dsregcmd) command. If you see `AzureAdJoined: YES` under `Device State`, try changing the user specified in the connection to the `user@domain.com` format.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

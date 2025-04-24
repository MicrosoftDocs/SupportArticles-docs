---
title: Session creation error codes in unattended desktop flow runs
description: Solves error codes related to session creation during unattended desktop flow runs in Power Automate.
author: johndund 
ms.author: johndund 
ms.date: 04/24/2025
ms.reviewer: madiazor, guco, fredg 
ms.custom: sap:Desktop flows\Unattended flow runtime errors
---
# Resolve session creation error codes for an unattended desktop flow run

This article provides background and potential solutions to the `SessionCreationError` and `SessionCreationErrorWithThirdPartyCredentialProvider` error codes that might occur during an unattended desktop flow run in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate

## Symptoms

Your [unattended desktop flow run](/power-automate/desktop-flows/run-unattended-desktop-flows) might fail with the `SessionCreationError` or `SessionCreationErrorWithThirdPartyCredentialProvider` error code.

## Cause

When an unattended session is run, Power Automate attempts to create a remote desktop (RDP) session on the target machine. If this session creation fails, you might receive one of the following error codes:

- [SessionCreationErrorWithThirdPartyCredentialProvider](#sessioncreationerrorwiththirdpartycredentialprovider)
- [SessionCreationError](#sessioncreationerror)

## SessionCreationErrorWithThirdPartyCredentialProvider

This error code occurs because third-party software interferes with Power Automate's ability to create a session on the machine. Power Automate doesn't support some third-party credential providers.

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

## SessionCreationError

This error code occurs when a session creation fails for an unknown reason.

### Resolution

To solve the issue:

- Ensure that you can remote desktop to the machine from another machine on your network. If you're using Windows Server, you can try to remote desktop to "localhost" from the local machine itself when logged in as another account. If these actions fail, see [General Remote Desktop connection troubleshooting](../../../windows-server/remote/rdp-error-general-troubleshooting.md).
- If you have a legal notice enabled for login, work with your system administrator to try disabling it. To see if the legal notice is activated, open Registry Editor and go to `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`. If `legalnoticecaption` or `legalnoticetext` isn't empty, work with your system administrator to disable the legal notice.
- Ensure that no third-party software is installed that might affect login or interfere with creating a remote desktop connection.
- If you use a domain account (DOMAIN\user) to connect, connectivity issues with the domain controller might prevent the session from opening correctly. Work with your system administrator to examine connectivity logs. If you're on a Microsoft Entra joined or Entra hybrid joined device, try using a UPN (`user@domain.com`). To see if you can use a UPN, go to **Start** > **Run**, and run the [dsregcmd /status](/entra/identity/devices/troubleshoot-device-dsregcmd) command. If you see `AzureAdJoined: YES` under `Device State`, try changing the user specified in the connection to the `user@domain.com` format.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

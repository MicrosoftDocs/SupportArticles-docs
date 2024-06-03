---
title: Troubleshoot session creation error codes in unattended desktop flow runs
description: Solves the error codes related to session creation during unattended desktop flow runs in Power Automate.
author: johndund # GitHub alias
ms.author: johndund # Microsoft alias
ms.date: 06/03/2024
ms.reviewer: 
ms.custom: sap:Desktop flows\Power Automate for desktop errors
---
# Troubleshoot session creation error codes for an unattended desktop flow run

This article provides background and potential solutions to the `SessionCreationError` and `SessionCreationErrorWithThirdPartyCredentialProvider` error codes that might be encountered during an unattended desktop flow run in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate

## Symptoms

Your [unattended desktop flow run](/power-automate/desktop-flows/run-unattended-desktop-flows) might fail with the `SessionCreationError` or `SessionCreationErrorWithThirdPartyCredentialProvider` error code.

## Cause

When an unattended session is run, Power Automate attempts to create a remote desktop (RDP) session on the target machine. If creating this session fails, you might receive one of the following error codes:

- [SessionCreationErrorWithThirdPartyCredentialProvider](#sessioncreationerrorwiththirdpartycredentialprovider)
- [SessionCreationError](#sessioncreationerror)

## SessionCreationErrorWithThirdPartyCredentialProvider

This error code occurs because a third-party software interferes with the ability of Power Automate to create a session on the machine. Power Automate doesn't support some third-party credential providers.

### Resolution

To resolve the issue, contact your administrator to uninstall the credential provider that's not supported by Power Automate.

You can find the full list of credential providers (many of which are built in) on your machine in the following registry key:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers`

Each subkey represents an installed credential provider. The following table lists the credential providers that Power Automate currently doesn't support. If you have the following registry key present, try working with your system administrator to uninstall the corresponding software.

| Name | Subkey name |
| :------------------------ | ---------------- |
| SailPoint Technologies Desktop Password Reset | 0094A34B-0BF0-4789-8B2D-8339E469D756 |

## SessionCreationError

This error code occurs when creating a session fails for an unknown reason.

### Resolution

To solve the issue:

- Ensure that you can remote desktop to the machine from another machine on your network. If you're using a Windows server, you can try to remote desktop to "localhost" from the local machine itself when logged in as another account. If these fails, see [general remote desktop troubleshooting](../../../windows-server/remote/rdp-error-general-troubleshooting.md).
- If you have a legal notice enabled for login, work with your system administrator to try disabling it. To see if the legal notice is activated, open Registry Editor and go to `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`. If  "legalnoticecaption" or "legalnoticetext" isn't empty, try working with your system administrator to disable the legal notice.
- Ensure that no third-party software is installed that might affect login or interfere with creating a remote desktop connection.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

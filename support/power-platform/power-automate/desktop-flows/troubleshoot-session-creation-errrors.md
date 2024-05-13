---
title: Troubleshoot session creation errors in unattended runs
description: Provides solutions to desktop flow unattended errors related to session creation.
author: johndund # GitHub alias
ms.author: johndund # Microsoft alias
ms.reviewer: 
ms.custom: sap:Desktop flows\Power Automate for desktop errors
---
# Troubleshoot SessionCreationError during Unattended runs

This article provides background and potential solutions to SessionCreationError and SessionCreationErrorWithThirdPartyCredentialProvider which may be encountered during an unattended desktop flow runs.

_Applies to:_ &nbsp; Power Automate

## Symptoms

Your desktop flow might fail to run with the error code `SessionCreationError` or `SessionCreationErrorWithThirdPartyCredentialProvider`.

## Cause

When an unattended session is run, Power Automate attempts to create a remote desktop session on the target machine. If creating this session fails, you may receive one of many errors:

- `SessionCreationErrorWithThirdPartyCredentialProvider`
- `SessionCreationErrror`

## Resolution

The resolution and troubleshooting depends on which error you receive.

#### SessionCreationErrorWithThirdPartyCredentialProvider

This occurs when we detected a third party piece of software which may be interfering with the ability of Power Automate to create a session on the machine.

##### Resolution

To resolve the issue, please uninstall the offending piece of software.

#### SessionCreationErrror

This errors occurs when session creation failed for an unknown reason.

##### Resolution

To troubleshoot the issue:

* Ensure that you can remote desktop to the machine from another machine on your network. If you're using a Windows server, you can try to remote desktop to "localhost" from the local machine itself when logged in as another account. If these fail, use general remote desktop [troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/remote/rdp-error-general-troubleshooting).
- If you have a legal notice enabled for login, work with your system administrator to try disabling it.If it doesn't, please follow standard 
- Ensure that no third-party software is installed that may affect login or interfere with creating a remote desktop connection. To check if you have a legal notice

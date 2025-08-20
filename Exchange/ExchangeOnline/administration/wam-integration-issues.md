---
title: Issues in Exchange Online PowerShell Module after WAM Integration
description: Resolves compatibility issues in Exchange Online PowerShell module after Web Account Manager integration.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrative Tasks
  - Exchange Online
  - CSSTroubleshoot
manager: dcscontentpm
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 08/20/2025
ms.reviewer: ninob, klahari, vivepai, bravirao
---
# Resolve issues in Exchange Online PowerShell module after WAM integration

Beginning in Exchange Online PowerShell module version 3.7.0, Microsoft is implementing Web Account Manager (WAM) as the default authentication broker for user authentication. Although WAM offers improved security and a streamlined user experience, it might cause compatibility challenges in some situations. This article discusses these situations and provides resolutions or workarounds for them, as appropriate.

> [!NOTE]
> Although you can use the **DisableWAM** switch together with the [Connect-ExchangeOnline](/powershell/module/exchangepowershell/connect-exchangeonline) command to disable WAM when you connect to Exchange Online PowerShell, you should use this option only as a temporary method. If you require assistance to resolve issues without having to disable WAM, contact Microsoft Support at [exo_wamissue@service.microsoft.com](mailto:exo_wamissue@service.microsoft.com).

## Scenario: Using the RunAs option

### Symptoms

When you run the `Connect-ExchangeOnline` PowerShell command under a different user context than the credentials that were used to sign in to Windows, WAM-based authentication fails.

In this scenario, you receive the following error message:

> One or more errors occurred. (Unknown Status: Unexpected    Error: 0xffffffff80070520    Context: A specified logon session does not exist. It may already have been terminated.    Tag: 0x21420087 (error code -2147023584) (internal error code 557973639))- at Microsoft.Exchange.Management.ExoPowershellSnapin.GetConnectionContext.ProcessRecord()     at System.Management.Automation.CommandProcessor.ProcessRecord();InnerException : Unknown Status: Unexpected    Error: 0xffffffff80070520    Context: A specified logon session does not exist. It may already have been terminated.    Tag: 0x21420087 (error code -2147023584) (internal error code 557973639)…;

### Cause

WAM relies on the active user session to load its plugins and to access cryptographic keys and certificates that are associated with a user profile. If you run PowerShell under a different context, this action isolates the session and prevents WAM from functioning correctly.

### Workaround

For security, you shouldn't use the `RunAs` option to run PowerShell commands. This method bypasses key protections and introduces risks that are associated with impersonation and session isolation.

Run PowerShell only in the same context as that of the signed-in Windows user to ensure compatibility with WAM. You can disable WAM temporarily by using the DisableWAM parameter together with the `Connect-ExchangeOnline` PowerShell command to connect to Exchange Online and then re-enable WAM.

## Scenario: Running GDAP flows

### Symptoms

In certain Granular Delegated Admin Privileges (GDAP) flows, WAM-based authentication causes tokens to miss required WIDS claims.

In this scenario, you receive the following error message:

> The role assigned to user 'userx@tenantx.onmicrosoft.com' isn't supported in this scenario.

### Cause

WAM might not correctly populate all the required claims in GDAP flows, especially if you use the `-DelegatedOrganization` parameter.

### Workaround

Disable WAM temporarily to connect to Exchange Online PowerShell in GDAP flows.

Collect diagnostic logs by using the -EnableErrorReporting parameter together with the `Connect-ExchangeOnline` PowerShell command, and send the logs to [exo_wamissue@service.microsoft.com](mailto:exo_wamissue@service.microsoft.com).

## Scenario: Using Windows Task Scheduler

### Symptoms

Scripts that use WAM-based authentication fail when they're run in the Windows Task Scheduler by having the **Run whether user is logged on or not** security option enabled.

In this scenario, you receive the following error message:

> One or more errors occurred. (Unknown Status: Unexpected    Error: 0xffffffff80070520    Context: A specified logon session does not exist. It may already have been terminated.    Tag: 0x21420087 (error code -2147023584) (internal error code 557973639))- at Microsoft.Exchange.Management.ExoPowershellSnapin.GetConnectionContext.ProcessRecord()     at System.Management.Automation.CommandProcessor.ProcessRecord();InnerException : Unknown Status: Unexpected    Error: 0xffffffff80070520    Context: A specified logon session does not exist. It may already have been terminated.    Tag: 0x21420087 (error code -2147023584) (internal error code 557973639)…;  

### Cause

WAM requires an active user session in order to function. In inactive sessions, critical components such as **%LOCALAPPDATA%**, cryptographic keys, and certificates are inaccessible.

When the script execution starts, it has to sign in to Exchange Online. However, if the user doesn't sign in to the system, the script sign-in fails because WAM doesn't have the required user information to facilitate the script's sign-in attempt.

### Workaround

To run automated scripts, use certificate-based authentication. This method is secure and recommended. Alternatively, you can run scripts by using scheduling methods that preserve the user session context.

---
title: Error AADSTS50020 when signing into OneDrive
description: You can't sign in to the OneDrive sync app if you see error AADSTS50020 because of cached identities from the previous tenant.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 164144
  - CSSTroubleshoot
ms.reviewer: salarson
appliesto: 
  - OneDrive for Business
search.appverid: 
  - MET150
  - SPO160
ms.date: 12/17/2023
---
# Error AADSTS50020 when signing in to the OneDrive sync app

## Symptoms

You can't sign in to the Microsoft OneDrive sync app, and you receive the following error message:

> AADSTS50020 User Account from identity provider does not exist in tenant and cannot access application (OneDrive SyncEngine).

## Cause

This issue might be caused by cached identities from the previous tenant. It most commonly occurs during a tenant-to-tenant migration.

For more information about other potential causes, see [Error AADSTS50020 - User account from identity provider does not exist in tenant](/troubleshoot/azure/active-directory/error-code-aadsts50020-user-account-identity-provider-does-not-exist).

## Resolution

To resolve this issue, remove the cached Microsoft Office account identities from the registry.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) in case problems occur.

1. Start Registry Editor.  
2. Locate the following registry entry:  

    `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Common\Identity`

3. Right-click **Identity**, and then select **Delete**.  

**Note:** If you have [Shared Computer Activation](/deployoffice/troubleshoot-shared-computer-activation#Enabled) enabled, also remove the Identity registry entry from `HKEY_USERS\<The user SID>\SOFTWARE\Microsoft\Office\16.0\Common`. To get the currently signed-in user's SID, run the `whoami /user` command in a Command Prompt window. If the issue persists, expand "**Section A: Remove Office licenses & cached accounts**" in [Clear prior activation information manually](/office/troubleshoot/activation/reset-office-365-proplus-activation-state#method-clear-prior-activation-information-manually), and then follow the steps in **Part 1: Remove previous Office activations** and **Part 3: Remove Office credentials stored in Windows Credential Manager**.

If you still experience the issue, follow these steps:

1. Sign out of OneDrive for Business.  
2. Remove all folders in the following locations:

    - *%localappdata%/Microsoft/OneAuth*
    - *%localappdata%/Microsoft/IdentityCache*
